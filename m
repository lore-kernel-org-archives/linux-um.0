Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Re: [uml-user] 2.6.13 / cannot set up LDT for
	thread-local storage
References: <2accc2ff0509111117747e8639@mail.gmail.com>
	<2accc2ff0509160423743a1ed6@mail.gmail.com>
	<2accc2ff050916060122acc08b@mail.gmail.com>
In-Reply-To: <2accc2ff050916060122acc08b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509161501.42947.rob@landley.net>
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
Date: Fri, 16 Sep 2005 15:01:42 -0500
To: user-mode-linux-devel@lists.sourceforge.net, nelsoneci@gmail.com
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-user@lists.sourceforge.net

On Friday 16 September 2005 08:01, Nelson Castillo wrote:
> On 9/16/05, Nelson Castillo <nelsoneci@gmail.com> wrote:
> > On 9/13/05, Blaisorblade <blaisorblade@yahoo.it> wrote:
> > sysvinit should have a way to add a variable to the
> > environment. Can it be done in intitab?
>
> I just fixed the patch for the FAQ. It's much simpler
> (and correct, I hope) now.

Hey, cool:

./linux rootfstype=hostfs rw init=/bin/sh LD_ASSUME_KERNEL=2.4.1 

Just gave my a shell prompt in skas0 mode on ubuntu.  Using unmodified 
2.6.13.1 with the .config I posted earlier.

---
sh-3.00# mount -t proc /proc /proc
sh-3.00# cat /proc/cpuinfo
processor       : 0
vendor_id       : User Mode Linux
model name      : UML
mode            : skas
host            : Linux driftwood 2.6.10-5-386 #1 Tue Apr 5 12:12:40 UTC 2005 
i686
bogomips        : 1268.12

sh-3.00#
---

Coolness. :)

Rob


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
