var data = {
    labels: terms_and_ratings_j[0],
    datasets: [
        {
            label: "Class Ratings",
            fillColor: "rgba(220,220,220,0.2)",
            strokeColor: "rgba(220,220,220,1)",
            pointColor: "rgba(220,220,220,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            // data: [6, 5, 8, 8, 5, 5, 4]
            data: terms_and_ratings_j[1]
        },
    ]
};

// function getChartData(terms_and_ratings) {
//   data[labels] = terms_and_ratings[0]
//   data[datasets][0][data] = terms_and_ratings[1]
//   console.log("AHH")
// }
// Get the context of the canvas element we want to select
var countries= document.getElementById("countries").getContext("2d");
new Chart(countries).Line(data);


