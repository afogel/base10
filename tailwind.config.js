const colors = require("tailwindcss/colors");

module.exports = {
  plugins: [
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/forms"),
    require("@tailwindcss/typography"),
    require("daisyui"),
  ],
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
  ],
  daisyui: {
    themes: [
      {
        emerald: {
          ...require("daisyui/src/theming/themes")["[data-theme=emerald]"],
          primary: "#45aeeb",
          "primary-focus": "#1d94da",
          ".bg-primary": {
            "background-color": "#45aeeb",
          },
          ".success-flash": {
            "background-color": colors.green[100],
            "border-color": colors.green[700],
            color: colors.green[700],
          },
          ".success-flash-hover": {
            "background-color": colors.green[200],
          },
          ".error-flash": {
            "background-color": colors.red[100],
            "border-color": colors.red[700],
            color: colors.red[700],
          },
          ".error-flash-hover": {
            "background-color": colors.red[200],
          },
          ".warn-flash": {
            "background-color": colors.amber[100],
            "border-color": colors.amber[700],
            color: colors.amber[700],
          },
          ".warn-flash-hover": {
            "background-color": colors.amber[200],
          },
          ".notice-flash": {
            "background-color": "#45aeeb",
            "border-color": "#0e5e96",
            color: "#0e5e96",
          },
          ".notice-flash-hover": {
            "background-color": "#bfe2f8",
          },
        },
      },
    ],
  },
};
