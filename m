Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Re: Problems about fork-not-clone (was: Re:
	[uml-user] UML exits after "tracing thread pid")
References: <1119527920.4679.15.camel@FC3-bernhard-1.acousta.local>
	<200507112321.20457.blaisorblade@yahoo.it>
	<200507120253.38724.rob@landley.net>
In-Reply-To: <200507120253.38724.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507120304.58283.rob@landley.net>
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
Date: Tue, 12 Jul 2005 03:04:57 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-user@lists.sourceforge.net

On Tuesday 12 July 2005 02:53, Rob Landley wrote:

> But how do you trigger it?
>
> I tried applying your "uml-2.6.12-bb2-skas0.patch.bz2" patch to 2.6.12.2,
> doing "make ARCH=um allnoconfig", following to .config:
>
> CONFIG_MODE_TT=y

Ahem.  Obviously, I skipped a step.  Those config entries (and the build 
process I was describing) are a cut and paste from my build process that uses 
UML to build a uclibc against more recent kernel headers that the host kernel 
it's running under (which would otherwise tend to cause segfaults).  That 
uses tt mode.

If I do what I just described, the result works just fine, but it's in tt 
mode.  Which is odd, because stock 2.6.12.2 does NOT work for me in tt mode: 
it goes:

Checking PROT_EXEC mmap in /tmp...OK
tracing thread pid = 11687

And then exits with no further explanation or printout.  (I get my shell 
prompt back but it's the host system's shell prompt.)  But with 
Blaisorblade's -skas0 patch, tt mode works.  (Go figure.)

However, the point of the patch is to try -skas0 mode, so I went in to "make 
ARCH=um menuconfig", switched off tt mode, and switched on skas mode.  (I did 
this instead of oldconfig.)

Then I got the trace from last message.

Sorry for the confusion.

Rob


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
