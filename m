Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzMXE-0007cB-N0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 15:16:12 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EzMXB-0005w9-1F
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 15:16:12 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20060118002225.003080b1.akpm@osdl.org>
	<200601181347.27276.blaisorblade@yahoo.it>
	<20060118213546.GC15828@mars.ravnborg.org>
In-Reply-To: <20060118213546.GC15828@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601190016.01573.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: Using compiler.h from uml userspace code (was: Re:
	uml build error)
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
Date: Thu, 19 Jan 2006 00:16:00 +0100
To: Sam Ravnborg <sam@ravnborg.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, jdike@addtoit.com

On Wednesday 18 January 2006 22:35, Sam Ravnborg wrote:
> On Wed, Jan 18, 2006 at 01:47:26PM +0100, Blaisorblade wrote:
> > Possible solutions below - akpm doesn't need to read this. Sam, instead,
> > please do read and give an opinion.

> First off. When I see #include 2foo.h" then this tell me that foo is
> found in the same dir as the .c file we are compiling.

Oops... with that "foo.h" I meant the same folder as compiler.h... I'm correct 
or not, with gcc?

> gcc though has a much more weak interpretation of the differences
> between include <foo.h> and #include "foo.h".

> The -I- flag to correct this stupidity is scheduled for removal and when
> I asked on the gcc list no-one bothered to answer so I assume this is
> all done now in 4.x.
> -I- had to purposes, but I cannot recall the other one right now.

1) Stop searching in "."
2) End listing of include search dirs to use only with "" quotes.

(From info gcc -> searching -I-, at least with 3.4).

> From a technical viewpoint nothing is wrong - the only thing being that
> human mortals may be confused when suddenly file are included using a
> different style than usual.

> > With that in, just symlinking include/linux/compiler-*.h into
> > arch/um/include would work well!

> > We prefer to avoid them included as <linux/compiler-*.h> because it could
> > conflict with host headers, unless it's possible to have our headers
> > searched before host ones.

> Thats perfectly doable if we talk kbuild.
> You can just assing to NOSTDINC_FLAGS the directories to search first.

The problem is that those files are building without NOSTDINC_FLAGS, because 
they are the USER_OBJS. Weren't for this they'd simply include 
<linux/compiler.h> and be done. However, I just saw that user supplied 
include directories are searched before system headers.

So, a simpler solution could be involve symlinking just a directory, where to 
put all related files (like linux/byteorder).

> In general I wish all symlinks in the build to hell.
> In many cases they are just repairing a badly thought directory
> structure include/asm being the worst evil of all.
> klibc does the same with no symlinks.

Hmm, how? Btw, I thought that klibc could be very useful for UML (either 
linking to it or taking code to replace glibc one and alter it at will - 
glibc is fairly unreadable for me, hope klibc is clearer).

For instance, since fork() (or actually, clone) + execvp() calls malloc (and 
so kmalloc) from a wrong context, we want to split execvp() into 
search_exec() and execve().

Doing that with glibc code felt horrible...
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
