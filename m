Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <417101F4.1050109@fastwebnet.it>
From: Primero <primero@fastwebnet.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2342BFC2C265256A31F6271B"
Subject: [uml-devel] UML Guests and CPU Performance.
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 16 Oct 2004 13:11:48 +0200
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2342BFC2C265256A31F6271B
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi ML, it is a little bit of time i've started using UML and i'm still 
"playing" with it. Anyway there's a thing that let me confused.

It seems to me that performance of UML Guest machine is sensibly worst 
then UML Host ... even if there is only one UML guest and no other 
processes sucking resources.

My Setup is:
Athlon 1000
512 RAM
1 GB tmpfs /tmp
30GB 4200 eide

The guest is started with 256MB of RAM

I can post /proc/cpuinfo:

Host:
model name      : AMD Athlon(tm) Processor
cpu MHz         : 1000.502
cache size      : 64 KB
bogomips        : 1970.17

Guest:
processor       : 0
vendor_id       : User Mode Linux
model name      : UML
mode            : skas
host            : Linux Pancho 2.6.8.1-cko8 #2 Mon Oct 11 17:03:08 CEST 
2004 i686
bogomips        : 1081.34


Here are results of Kernel Time compiling with the same .config:

Host:
real    15m27.226s
user    13m49.185s
sys     1m12.144s

Guest:
real    29m27.603s
user    21m16.970s
sys     7m59.080s


The Bogomips of the Guest are the half of the Host and compiling time is 
almost the double.

I want to know if this is "Normal" or i have to look for some errors in 
my configuration.

Thx
Primero

-- 
---------------------------------------
#######################################

"Linux, the choice of a GNU generation"
     ==Micro$oft - just say NO== 

#######################################
---------------------------------------


--------------enig2342BFC2C265256A31F6271B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBcQH0OGoQ6Fir3nYRAu2kAKCFHmcOdxvCxrRS5rRipjQk5GijtgCfUJ6x
GkI9qNzSPSsjUEesnOIwclA=
=xUYF
-----END PGP SIGNATURE-----

--------------enig2342BFC2C265256A31F6271B--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
