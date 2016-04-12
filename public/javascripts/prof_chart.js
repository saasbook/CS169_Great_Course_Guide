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
            data: terms_and_ratings_j[1]
        },
    ]
};
// Get the context of the canvas element we want to select
var graph= document.getElementById("graph").getContext("2d");
new Chart(graph).Line(data);


