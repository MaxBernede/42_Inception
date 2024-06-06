<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'wpuser' );

/** Database password */
define( 'DB_PASSWORD', 'password' );

/** Database hostname */
define( 'DB_HOST', 'mariadb' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          'j=|=Ir,<`DXg=j[`Y2Jt#,pCa&gV_hCa&|0mVMDyyEc)h:g-`^95rZB~5 Hcv`JS' );
define( 'SECURE_AUTH_KEY',   '6 S[~YIC>OR2;aNuKL*yUj-ext]AP}qe*X~b!X+>rTju*BuX]mAdxW^2W`?!QyF3' );
define( 'LOGGED_IN_KEY',     'i7cQI;Ts={8m~LMP*aD8z}$q/TGQ}f,K,`EzBN{m&pHCjZc2LSbj$CT#]0t6VHoG' );
define( 'NONCE_KEY',         ')LG$J6}YeQ1WuL##Y,G_].MTg<FDO2neaKTvoVEJTUPE1!8r:vig&N7G+,dc|@_P' );
define( 'AUTH_SALT',         'jx&<x[?_g+e_y}? q 91-aXVq]lawX +-pI=nNOI&?Zec79nWH:#bQm`y?},Nd=w' );
define( 'SECURE_AUTH_SALT',  'B<[I0_Lv vf}0%f5,{4) FI uJfD+9 ,A)Z9!D/ghnLU.Qsi#7VnaSV%Wv]C1*f_' );
define( 'LOGGED_IN_SALT',    'Tbm5TG~Y2]^XjV#!+:o7AdC2zCAlJ.Pw}C3Ywd>yNl8MX;v^~!FqH70V?ksa[<&j' );
define( 'NONCE_SALT',        '!4J+ICyG$?6rgYWx$`7s!0kXBsNv|@dYm31~.1f:zv)AhxjS;=Dh)P3Tm1Z<ubbd' );
define( 'WP_CACHE_KEY_SALT', 'o%}Ith0rXa)Y`VX1~@&UIkz-Fw3x6#|NRoMtnT9?czCoB*keK4`%*-Jv&P423PG*' );


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';


/* Add any custom values between this line and the "stop editing" line. */



/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
if ( ! defined( 'WP_DEBUG' ) ) {
	define( 'WP_DEBUG', false );
}

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
