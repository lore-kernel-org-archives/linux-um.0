Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: [uml-devel] Fixing the 2.4 bugs - patches against 2.4.24-1um
In-Reply-To: <200407012050.14867.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.58.0407071420550.9924@tuxrocks.com>
References: <200407012050.14867.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 7 Jul 2004 14:51:02 -0600 (MDT)
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

On Thu, 1 Jul 2004, BlaisorBlade wrote:
> I've started working also on UML/2.4.
> 
> Today I've split the changes between 2.4.24-1um and 2.4.24-2um into several 
> patches; the HUMFS ones are carefully split out, but I've separated even the 
> others. Now I need testers. Lots of people cannot use UML patches later than 
> 2.4.24-1um, since they contain a lot of Hostfs bugs and some stability 
> issues. Now, if you use just some patches, you'll avoid the bugs in the 
> other.
> 
> You should apply surely the first 3 patches, IMHO; the other ones should not 
> hurt; inside txt/ there is a description of them.
<snip>

BlaisorBlade,

Thank you for splitting these patches out.  Using them, I was able to
track down and squash a kernel panic issue I've had with all 2.4 patch
versions after 2.4.24-1um!

My panic, for reference - 
http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=108344473226217&w=2

In this case, the problem was actualy in the first 'mini-changes' patch, 
and the fix (diff to the 2.4.24-2um patch):
--- uml-patch-2.4.24-2  2004-04-07 14:31:13.000000000 -0600
+++ uml-patch-2.4.24-2_frank    2004-07-07 14:26:49.000000000 -0600
@@ -35588,7 +35588,7 @@
 +
 +ARCH_CFLAGS = -U__$(SUBARCH)__ -U$(SUBARCH)
 +
-+ifeq ($(CONFIG_GPROF),n)
++ifneq ($(CONFIG_GPROF),y)
 +ARCH_CFLAGS += -DUM_FASTCALL
 +endif
 +

The configuration program will either set CONFIG_GPROF to 'y', or it will 
put "# CONFIG_GPROF is not set" into the .config file.  CONFIG_GPROF will 
never be 'n', at least in my understanding.

I believe this bug may affect stability for a number of people, and it has
existed since 2.4.24-2um first came out.  It may not solve any underlying
problems, but I'd like to hear if it helps anyone else.

Frank
---------------------------------------------------------------------------
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
