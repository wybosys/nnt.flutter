const ora = require('ora')
const chalk = require('chalk')
const webpack = require('webpack')
const program = require('commander')
const fs = require('fs')
const path = require('path')

const produes5 = require('./webpack.es5.config')

const cfg_produs = [produes5]
const cfg_devels = []
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

