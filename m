Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Sun, 8 Nov 2009 21:23:07 +0100 (CET)
From: Julia Lawall <julia@diku.dk>
In-Reply-To: <20091108184722.GA1647@mit.edu>
Message-ID: <Pine.LNX.4.64.0911082103000.8143@ask.diku.dk>
References: <cover.1257602781.git.andre.goddard@gmail.com>
	<7d5883637aa976b54e944998f635d47a41618a75.1257602781.git.andre.goddard@gmail.com>
	<20091108184722.GA1647@mit.edu>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH v4 12/12] tree-wide: convert open calls to
 remove spaces to skip_spaces() lib function
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Theodore Tso <tytso@mit.edu>
Cc: Pavel Roskin <proski@gnu.org>, Stefan Haberland <stefan.haberland@de.ibm.com>, Jan Kara <jack@suse.cz>, linux-cachefs@redhat.com, Mike Snitzer <snitzer@redhat.com>, Neil Brown <neilb@suse.de>, Frederic Weisbecker <fweisbec@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steve Dickson <steved@redhat.com>, "James E . J . Bottomley" <jejb@parisc-linux.org>, David Howells <dhowells@redhat.com>, ibm-acpi-devel@lists.sourceforge.net, dm-devel@redhat.com, "H . Peter Anvin" <hpa@zytor.com>, Daire Byrne <Daire.Byrne@framestore.com>, Alasdair G Kergon <agk@redhat.com>, Greg Banks <gnb@melbourne.sgi.com>, Stefan Weinhuber <wein@de.ibm.com>, Eric Sandeen <sandeen@redhat.com>, Adam Belay <abelay@mit.edu>, Helge Deller <deller@gmx.de>, x86@kernel.org, James Morris <jmorris@namei.org>, Takashi Iwai <tiwai@suse.de>, =?iso-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, WANG Cong <wangcong@zeuux.org>, Roman Hoog Antink <rha@open.ch>, linux-ext4@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, Andrea Righi <righi.andrea@gmail.com>, alsa-devel@alsa-project.org, Len Brown <len.brown@intel.com>, Samuel Ortiz <samuel@sortiz.org>, coreteam@netfilter.org, user-mode-linux-devel@lists.sourceforge.net, linux-s390@vger.kernel.org, Trond Myklebust <Trond.Myklebust@netapp.com>, Jeff Dike <jdike@addtoit.com>, Rusty Russell <rusty@rustcorp.com.au>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sitsofe Wheeler <sitsofe@yahoo.com>, Steven Rostedt <rostedt@goodmis.org>, linux-raid@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andreas Dilger <adilger@sun.com>, Pekka Enberg <penberg@cs.helsinki.fi>, Mikulas Patocka <mpatocka@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, user-mode-linux-user@lists.sourceforge.net, Jaroslav Kysela <perex@perex.cz>, Thomas Gleixner <tglx@linutronix.de>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Jan Engelhardt <jengelh@medozas.de>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Andre Noll <maan@systemlinux.org>, netfilter-devel@vger.kernel.org, linux-parisc@vger.kernel.org, "Martin K . Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org, Jason Baron <jbaron@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>, Roel Kluin <roel.kluin@gmail.com>, linux-kernel@vger.kernel.org, Stoyan Gaydarov <stoyboyker@gmail.com>, Patrick McHardy <kaber@trash.net>, Kyle McMartin <kyle@mcmartin.ca>, Christof Schmitt <christof.schmitt@de.ibm.com>, netfilter@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Joe Perches <joe@perches.com>, linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>, "David S . Miller" <davem@davemloft.net>

> > Also, while at it, if we see (*str && isspace(*str)), we can be sure to
> > remove the first condition (*str) as the second one (isspace(*str)) also
> > evaluates to 0 whenever *str == 0, making it redundant. In other words,
> > "a char equals zero is never a space".

I tried the following semantic patch (http://coccinelle.lip6.fr), and got 
the results below.

@@
expression str;
@@

( // ignore skip_spaces cases
 while (*str &&  isspace(*str)) { \(str++;\|++str;\) }
|
- *str && 
  isspace(*str)
)

I haven't checked the results in any way, however.

julia

diff -u -p a/drivers/leds/led-class.c b/drivers/leds/led-class.c
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -50,7 +50,7 @@ static ssize_t led_brightness_store(stru
 	unsigned long state = simple_strtoul(buf, &after, 10);
 	size_t count = after - buf;
 
-	if (*after && isspace(*after))
+	if (isspace(*after))
 		count++;
 
 	if (count == size) {
diff -u -p a/drivers/leds/ledtrig-timer.c b/drivers/leds/ledtrig-timer.c
--- a/drivers/leds/ledtrig-timer.c
+++ b/drivers/leds/ledtrig-timer.c
@@ -83,7 +83,7 @@ static ssize_t led_delay_on_store(struct
 	unsigned long state = simple_strtoul(buf, &after, 10);
 	size_t count = after - buf;
 
-	if (*after && isspace(*after))
+	if (isspace(*after))
 		count++;
 
 	if (count == size) {
@@ -127,7 +127,7 @@ static ssize_t led_delay_off_store(struc
 	unsigned long state = simple_strtoul(buf, &after, 10);
 	size_t count = after - buf;
 
-	if (*after && isspace(*after))
+	if (isspace(*after))
 		count++;
 
 	if (count == size) {
diff -u -p a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
--- a/drivers/video/backlight/lcd.c
+++ b/drivers/video/backlight/lcd.c
@@ -101,7 +101,7 @@ static ssize_t lcd_store_power(struct de
 	int power = simple_strtoul(buf, &endp, 0);
 	size_t size = endp - buf;
 
-	if (*endp && isspace(*endp))
+	if (isspace(*endp))
 		size++;
 	if (size != count)
 		return -EINVAL;
@@ -140,7 +140,7 @@ static ssize_t lcd_store_contrast(struct
 	int contrast = simple_strtoul(buf, &endp, 0);
 	size_t size = endp - buf;
 
-	if (*endp && isspace(*endp))
+	if (isspace(*endp))
 		size++;
 	if (size != count)
 		return -EINVAL;
diff -u -p a/drivers/video/display/display-sysfs.c b/drivers/video/display/display-sysfs.c
--- a/drivers/video/display/display-sysfs.c
+++ b/drivers/video/display/display-sysfs.c
@@ -67,7 +67,7 @@ static ssize_t display_store_contrast(st
 	contrast = simple_strtoul(buf, &endp, 0);
 	size = endp - buf;
 
-	if (*endp && isspace(*endp))
+	if (isspace(*endp))
 		size++;
 
 	if (size != count)
diff -u -p a/drivers/video/output.c b/drivers/video/output.c
--- a/drivers/video/output.c
+++ b/drivers/video/output.c
@@ -50,7 +50,7 @@ static ssize_t video_output_store_state(
 	int request_state = simple_strtoul(buf,&endp,0);
 	size_t size = endp - buf;
 
-	if (*endp && isspace(*endp))
+	if (isspace(*endp))
 		size++;
 	if (size != count)
 		return -EINVAL;

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

