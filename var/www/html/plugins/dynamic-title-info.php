<?php

/**
 * Dynamic Title Info (Distinguish the current environment, e.g. prod or dev)
 *
 * @author SolidZORO, solidzoro@live.com
 */
class AdminerDynamicTitleInfo
{
    function head()
    {
        // for IDE syntax highlighting hacking :/
        $scriptCode = "<script>
            window.addEventListener('DOMContentLoaded', () => {
              const hostname = location.hostname;
            
              const htmlElm = document.querySelector('html');
              const bodyElm = document.querySelector('body');
              const h1Elm = document.querySelector('#menu #h1');
              const menuElm = document.querySelector('#menu h1');
              const versionElm = document.querySelector('#menu .version');
              
              // for dev
              h1Elm.text = hostname;
              let globalBgColor = '#fff';
              let textColor = '#e8ff00';
              let bgColor = '#111';
            
              // for prod
              if (!['localhost', '192.168.', '127.0.'].includes(hostname)) {
                h1Elm.text = 'production';
                
                globalBgColor = '#f9fbe7';
                textColor = '#fff';
                bgColor = '#4caf50';
              }
              
              h1Elm.style.color = textColor;
              menuElm.style.backgroundColor = bgColor;
            
              versionElm.style.fontSize = 'xx-small';
              versionElm.style.color = textColor;
              htmlElm.style.backgroundColor = globalBgColor;
              bodyElm.style.backgroundColor = globalBgColor;
            });
        </script>";


        echo script(str_replace(['<script>', '</script>'], "", $scriptCode));
    }
}
