const express = require("express");
const app = express();

app.use(express.json());

// In-memory storage for activities
let activities = [];

// GET all activities
app.get("/activities", (req, res) => {
  res.json({
    status: "success",
    data: activities
  });
});

// POST new activity
app.post("/activities", (req, res) => {
  const { latitude, longitude, imageBase64, timestamp, address } = req.body;

  if (!latitude || !longitude || !imageBase64 || !timestamp || !address) {
    return res.status(400).json({ message: "Missing fields" });
  }

  const newActivity = {
    id: Date.now(),
    latitude,
    longitude,
    imageBase64,
    timestamp,
    address
  };

  activities.push(newActivity);

  console.log("New Activity Added:", newActivity);

  res.json({
    message: "Activity added successfully",
    activity: newActivity
  });
});

// Start server
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`SmartTracker API running on http://localhost:${PORT}`);
});
