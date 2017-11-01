import scrapy
import re


class HKNSpider(scrapy.Spider):
    name = "hkn"

    start_urls = [
        "https://hkn.eecs.berkeley.edu/coursesurveys/"
    ]

    def parse(self, response):
        base_url = "https://hkn.eecs.berkeley.edu"
        course_dict = {}
        course_urls = response.xpath("//area/@href")
        for cu in course_urls:
            uri = cu.extract()
            uri_parts = uri.split("/")
            course_name = uri_parts[3] + uri_parts[4]
            course_dict[course_name] = {"url": base_url + uri}
            if uri:
                uri = response.urljoin(uri)
                print "Processing Course Url: {0}".format(uri)
                yield scrapy.Request(uri, callback=self.course_parse, meta={"cn": course_name})
        yield course_dict

    def course_parse(self, response):
        table_id = "\'ratings\'"
        table = response.xpath(".//table[@id=" + table_id + "]")

        ignore = ["Sections", "Instructor", "Teaching Effectiveness", "How worthwhile was this course?"]
        stop = "Overall Rating"

        if len(table) == 1:
            table = table[0]
            sem_dict = {}
            sem_re = re.compile("[Fall, Spring, Summer]+\s+\d{4}")
            # can use regex for the float rating
            point_re = re.compile("\d+?\.+\d")

            sem = None
            instructor = None
            point_list = []
            for rt in table.xpath(".//text()").extract():
                rt = rt.strip().lstrip("/").strip()
                if rt:
                    if rt == stop:
                        break
                    elif sem_re.match(rt):
                        sem = rt
                        sem_dict[sem] = {}
                    else:
                        if sem in sem_dict:
                            if rt not in ignore:
                                try:
                                    point_list.append(float(rt))
                                except ValueError:
                                    if point_list and instructor:
                                        sem_dict[sem][instructor] = point_list
                                    instructor = rt
                                    point_list = []

            yield {"course": response.meta["cn"], "semesters": sem_dict}
