'use strict'
const path = require("path");
const TsconfigPathsPlugin = require('tsconfig-paths-webpack-plugin');
const fs = require("fs");
const com = require("./common");

function resolve(dir) {
  return path.join(__dirname, '..', dir)
}

module.exports = {
  mode: 'production',
  context: path.resolve(__dirname, '../'),
  entry: com.ListEntries({}),
  output: {
    filename: "[name].es5.min.js",
    path: resolve("dist")
  },
  resolve: {
    extensions: ['.js', '.ts'],
    alias: {
      '@': resolve('src')
    },
    plugins: [
      new TsconfigPathsPlugin()
    ]
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        loader: 'babel-loader',
        include: [resolve('src')]
      },
      {
        test: /\.ts$/,
        loader: 'ts-loader',
        include: [resolve('src')],
        options: {
          compilerOptions: {
            target: "es5"
          }
        }
      }
    ]
  },
  externals: {
    yiyou: 'yiyou'
  },
  plugins: []
}
