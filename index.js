const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

const messages = process.env.MESSAGE || 'Hello World!';

app.get("/", (req, res) => {
    res.send(messages);
});

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});