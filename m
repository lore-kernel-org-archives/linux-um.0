Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Br73L-0002b2-Ay for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 31 Jul 2004 20:30:27 -0700
Received: from sccrmhc13.comcast.net ([204.127.202.64])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Br73L-0000KE-0u for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 31 Jul 2004 20:30:27 -0700
Message-ID: <410C6367.3090206@hevanet.com>
From: Matt Clay <mattclay@hevanet.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: Bug#260111: user-mode-linux: upgrade hangs at
	"NET4: Linux TCP/IP 1.0 for NET4.0 "
References: <200407280315.08207.alydar@users.sourceforge.net>
	<200407281722.i6SHM6eh002963@ccure.user-mode-linux.org>
	<200407291430.18818.alydar@users.sourceforge.net>
	<200407292234.04279.alydar@users.sourceforge.net>
	<200407301723.i6UHNeUE002844@ccure.user-mode-linux.org>
	<410A833F.9030207@hevanet.com>
	<200407301849.i6UInpUE003226@ccure.user-mode-linux.org>
In-Reply-To: <200407301849.i6UInpUE003226@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Sat, 31 Jul 2004 20:28:39 -0700
To: Jeff Dike <jdike@addtoit.com>
Cc: Allen Chan <alydar@users.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net, 260111@bugs.debian.org

Jeff Dike wrote:
> 
>>Works for me.  What still bothers me is that turning on debugging
>>symbols was "fixing" it for me as well.
> 
> Yeah, this definitely needs more investigation.

This patch seems to fix the problem by adding error handling to
the tcsetattr call in generic_console_write.

  - Matt

--- um.orig/arch/um/drivers/chan_kern.c	2004-07-26 11:43:52.000000000 -0700
+++ um/arch/um/drivers/chan_kern.c	2004-07-31 19:38:51.000000000 -0700
@@ -117,15 +117,15 @@
  {
  	struct termios save, new;
  	int err;
+	int changed = 0;

-	if(isatty(fd)){
-		tcgetattr(fd, &save);
+	if(isatty(fd) && tcgetattr(fd, &save) == 0) {
  		new = save;
  		new.c_oflag |= OPOST;
-		tcsetattr(fd, TCSAFLUSH, &new);
+		if(tcsetattr(fd, TCSAFLUSH, &new) == 0) changed = 1;
  	}
  	err = generic_write(fd, buf, n, NULL);
-	if(isatty(fd)) tcsetattr(fd, TCSAFLUSH, &save);
+	if(changed) tcsetattr(fd, TCSAFLUSH, &save);
  	return(err);
  }



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
