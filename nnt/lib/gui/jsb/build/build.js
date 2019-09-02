const ora = require('ora')
const chalk = require('chalk')
const webpack = require('webpack')
const program = require('commander')
const fs = require('fs')
const path = require('path')

const produ = require('./webpack.config')
const devel = require('./webpack.develop.config')
const produp = require('./webpack.promise.config')
const develp = require('./webpack.promise.develop.config')
const produes6 = require('./webpack.es6.config')
const develes6 = require('./webpack.es6.develop.config')
const produes5 = require('./webpack.es5.config')
const develes5 = require('./webpack.es5.develop.config')

const cfg_produs = [produ, produp, produes5, produes6]
const cfg_devels = [devel, develp, develes5, develes6]
const cfg_all = [].concat(cfg_produs).concat(cfg_devels)

async function BuildProdu() {
  return new Promise(function (resolve, reject) {
    const spinner = ora('building for production...')
    spinner.start()

    webpack(produ, (err, stats) => {
      spinner.stop()
      if (err) throw err
      process.stdout.write(stats.toString({
        colors: true,
        modules: false,
        children: false, // If you are using ts-loader, setting this to true will make TypeScript errors show up during build.
        chunks: false,
        chunkModules: false
      }) + '\n\n')

      if (stats.hasErrors()) {
        console.log(chalk.red('  Build failed with errors.\n'))
        reject()
      }

      console.log(chalk.cyan('  Build complete.\n'))
      resolve()
    })
  })
}

async function BuildDevel() {
  return new Promise(function (resolve, reject) {
    const spinner = ora('building for development...')
    spinner.start()

    webpack(devel, (err, stats) => {
      spinner.stop()
      if (err) throw err
      process.stdout.write(stats.toString({
        colors: true,
        modules: false,
        children: false, // If you are using ts-loader, setting this to true will make TypeScript errors show up during build.
        chunks: false,
        chunkModules: false
      }) + '\n\n')

      if (stats.hasErrors()) {
        console.log(chalk.red('  Build failed with errors.\n'))
        reject()
      }

      console.log(chalk.cyan('  Build complete.\n'))
      resolve()
    })
  })
}

async function BuildProdu_Promise() {
  return new Promise(function (resolve, reject) {
    const spinner = ora('building for promise production...')
    spinner.start()

    webpack(produp, (err, stats) => {
      spinner.stop()
      if (err) throw err
      process.stdout.write(stats.toString({
        colors: true,
        modules: false,
        children: false, // If you are using ts-loader, setting this to true will make TypeScript errors show up during build.
        chunks: false,
        chunkModules: false
      }) + '\n\n')

      if (stats.hasErrors()) {
        console.log(chalk.red('  Build failed with errors.\n'))
        reject()
      }

      console.log(chalk.cyan('  Build complete.\n'))
      resolve()
    })
  })
}

async function BuildDevel_Promise() {
  return new Promise(function (resolve, reject) {
    const spinner = ora('building for promise development...')
    spinner.start()

    webpack(develp, (err, stats) => {
      spinner.stop()
      if (err) throw err
      process.stdout.write(stats.toString({
        colors: true,
        modules: false,
        children: false, // If you are using ts-loader, setting this to true will make TypeScript errors show up during build.
        chunks: false,
        chunkModules: false
      }) + '\n\n')

      if (stats.hasErrors()) {
        console.log(chalk.red('  Build failed with errors.\n'))
        reject()
      }

      console.log(chalk.cyan('  Build complete.\n'))
      resolve()
    })
  })
}

async function BuildProdu_ES6() {
  return new Promise(function (resolve, reject) {
    const spinner = ora('building for es6 production...')
    spinner.start()

    webpack(produes6, (err, stats) => {
      spinner.stop()
      if (err) throw err
      process.stdout.write(stats.toString({
        colors: true,
        modules: false,
        children: false, // If you are using ts-loader, setting this to true will make TypeScript errors show up during build.
        chunks: false,
        chunkModules: false
      }) + '\n\n')

      if (stats.hasErrors()) {
        console.log(chalk.red('  Build failed with errors.\n'))
        reject()
      }

      console.log(chalk.cyan('  Build complete.\n'))
      resolve()
    })
  })
}

function BuildDevel_ES6() {
  return new Promise(function (resolve, reject) {
    const spinner = ora('building for es6 development...')
    spinner.start()

    webpack(develes6, (err, stats) => {
      spinner.stop()
      if (err) throw err
      process.stdout.write(stats.toString({
        colors: true,
        modules: false,
        children: false, // If you are using ts-loader, setting this to true will make TypeScript errors show up during build.
        chunks: false,
        chunkModules: false
      }) + '\n\n')

      if (stats.hasErrors()) {
        console.log(chalk.red('  Build failed with errors.\n'))
        reject()
      }

      console.log(chalk.cyan('  Build complete.\n'))
      resolve()
    })
  })
}

async function BuildProdu_ES5() {
  return new Promise(function (resolve, reject) {
    const spinner = ora('building for es5 production...')
    spinner.start()

    webpack(produes5, (err, stats) => {
      spinner.stop()
      if (err) throw err
      process.stdout.write(stats.toString({
        colors: true,
        modules: false,
        children: false, // If you are using ts-loader, setting this to true will make TypeScript errors show up during build.
        chunks: false,
        chunkModules: false
      }) + '\n\n')

      if (stats.hasErrors()) {
        console.log(chalk.red('  Build failed with errors.\n'))
        reject()
      }

      console.log(chalk.cyan('  Build complete.\n'))
      resolve()
    })
  })
}

async function BuildDevel_ES5() {
  return new Promise(function (resolve, reject) {
    const spinner = ora('building for es5 development...')
    spinner.start()

    webpack(develes5, (err, stats) => {
      spinner.stop()
      if (err) throw err
      process.stdout.write(stats.toString({
        colors: true,
        modules: false,
        children: false, // If you are using ts-loader, setting this to true will make TypeScript errors show up during build.
        chunks: false,
        chunkModules: false
      }) + '\n\n')

      if (stats.hasErrors()) {
        console.log(chalk.red('  Build failed with errors.\n'))
        reject()
      }

      console.log(chalk.cyan('  Build complete.\n'))
      resolve()
    })
  })
}

async function BuildDev() {
  await BuildProdu()
  await BuildDevel()

  await BuildProdu_Promise()
  await BuildDevel_Promise()

  await BuildProdu_ES5()
  await BuildDevel_ES5()

  await BuildProdu_ES6()
  await BuildDevel_ES6()
}

if (require.main == module) {
  BuildDev()
}

function resolve(dir) {
  return path.join(__dirname, '..', dir)
}

function ChangeOutputDir(relvdir) {
  var dir = resolve(relvdir)
  cfg_all.forEach(e => {
    e.output.path = dir
  })
}

module.exports = {
  BuildDev,

  BuildProdu,
  BuildProdu_Promise,
  BuildProdu_ES5,
  BuildProdu_ES6,

  ChangeOutputDir
}

