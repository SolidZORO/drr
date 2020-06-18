<?php

/**
 * Dynamic Title Info (Distinguish the current environment, e.g. prod or dev)
 *
 * Adminer API @link https://www.adminer.org/en/extension/#api
 *
 * @author SolidZORO, solidzoro@live.com
 */
class AdminerDynamicTitleInfo
{
    private $isLocalhost;

    /**
     * AdminerDynamicTitleInfo constructor.
     *
     * @param null $isLocalhost
     */
    function __construct($isLocalhost = null)
    {
        $this->isLocalhost = $isLocalhost;
    }


    /**
     * @return string
     */
    private function _getHttpHostName(): string
    {
        if (!$_SERVER['HTTP_HOST']) {
            return 'not-host';
        }

        $hostArr = explode(':', $_SERVER['HTTP_HOST']);
        if (!$hostArr) {
            return 'not-host-arr';
        }

        return $hostArr[0];
    }

    /**
     * @param string[] $whitelist
     *
     * @return bool
     */
    private function _isLocalhost($whitelist = ['127.0.0.1', 'localhost', '::', '::1', '::ffff:']): bool
    {
        $this->isLocalhost = in_array($this->_getHttpHostName(), $whitelist);

        return $this->isLocalhost;
    }

    /**
     * @return string
     */
    function name(): string
    {
        $titleName = $this->_isLocalhost() ? $this->_getHttpHostName() : 'production';

        return "<span id='h1'>{$titleName}</span>";
    }

    /**
     * @return void
     */
    function head(): void
    {
        // for prod
        $prodStyle = [
            '--global-bg-color' => '#f9fbe7',
            '--text-color'      => '#fff',
            '--bg-color'        => '#4caf50',
        ];

        // for dev
        $devStyle = [
            '--global-bg-color' => '#fff',
            '--text-color'      => '#e8ff00',
            '--bg-color'        => '#111',
        ];

        $style = $this->isLocalhost ? $devStyle : $prodStyle;

        echo "<style>
          html, body {
            background-color: {$style['--global-bg-color']};
          }

          #menu .version {
            font-size: 10px;
          }
          
          #menu h1 {
            background-color: {$style['--bg-color']};
            transition: all 0.3s;
          }
          
          #menu #h1, 
          #menu .version {
            color: {$style['--text-color']};
            transition: all 0.3s;
          }
        </style>";
    }
}
