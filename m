Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BqfAb-0002SX-Fn for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jul 2004 14:44:05 -0700
Received: from w218.z064002068.nyc-ny.dsl.cnc.net ([64.2.68.218])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1BqfAa-0007S9-Pf for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jul 2004 14:44:05 -0700
From: Allen Chan <alydar@users.sourceforge.net>
References: <200407280315.08207.alydar@users.sourceforge.net>
	<410A833F.9030207@hevanet.com>
	<200407301849.i6UInpUE003226@ccure.user-mode-linux.org>
In-Reply-To: <200407301849.i6UInpUE003226@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407301744.02391.alydar@users.sourceforge.net>
Subject: [uml-devel] Re: Bug#260111: user-mode-linux: upgrade hangs at "NET4:
	Linux TCP/IP 1.0 for NET4.0 "
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
Date: Fri, 30 Jul 2004 17:44:00 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

FYI... The same problem occurs in the 2.6.7-1um kernel after applying 
the remove-user-code patch from the "Current patches" site.  Except 
this time, instead of hanging, the guest kernel simply exits without 
warning.  The last output lines before exiting were:

...... [snipped] ......
Initializing stdio console driver
kjournald starting.  Commit interval 5 seconds

While compiling chan_kern.c, the following warnings were issued:

  CC      arch/um/drivers/chan_kern.o
arch/um/drivers/chan_kern.c: In function `generic_console_write':
arch/um/drivers/chan_kern.c:121: warning: implicit declaration of 
function `isatty'
arch/um/drivers/chan_kern.c:122: warning: implicit declaration of 
function `tcgetattr'
arch/um/drivers/chan_kern.c:125: warning: implicit declaration of 
function `tcsetattr'
arch/um/drivers/chan_kern.c: At top level:
arch/um/drivers/chan_kern.c:79: warning: `not_configged_ops' defined 
but not used

While isatty() is in <unistd.h> and tcgetattr() and tcsetattr() are in 
<termios.h> in /usr/include, there does not appear to exist 
equivalent kernel header files that will make those warnings go away 
for chan_kern.c.  Do these functions have to be implemented 
differently if placed at the kernel level?

On Friday 30 July 2004 02:49 pm, Jeff Dike wrote:
> Yeah, this definitely needs more investigation.



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
