Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EGLY2-00028h-Bh	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Sep 2005 12:06:58 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EGLY0-0000ig-Nt
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Sep 2005 12:06:58 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [uml-user] 2.6.13 / cannot set up LDT for
	thread-local storage
References: <2accc2ff0509111117747e8639@mail.gmail.com>
	<200509131952.22631.blaisorblade@yahoo.it>
	<2accc2ff0509160423743a1ed6@mail.gmail.com>
In-Reply-To: <2accc2ff0509160423743a1ed6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509162104.40771.blaisorblade@yahoo.it>
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
Date: Fri, 16 Sep 2005 21:04:40 +0200
To: user-mode-linux-devel@lists.sourceforge.net, nelsoneci@gmail.com
Cc: user-mode-linux-user@lists.sourceforge.net

On Friday 16 September 2005 13:23, Nelson Castillo wrote:
> On 9/13/05, Blaisorblade <blaisorblade@yahoo.it> wrote:
> (cut)


> That is as maybe, but /etc/environment is the
> only shell-agnostic file there is, and where it can be
> used, it certainly serves a good purpose.
> ---------------------------------------

> I did 2 equivalent tests
>   1) patching init/main.c to add the variable to the environment
>   2) using a wrapper to /sbin/init
>

> sysvinit should have a way to add a variable to the
> environment. Can it be done in intitab?
It can be done via adding LD_ASSUME_KERNEL=2.4.1 to the kernel command line.

> - Do they mean standard in Debian?
No idea about that - but I've never seen this file, so I assume it's Debian 
specific.
> BTW,

> - when is NPTL (not) supported in UML?

> I'm sending for your consideration a small patch for the FAQ
>  (that may need some update. I'll do it as I learn more about
> this issue).
I've not yet read the patch, and likely I won't before you generate it with 
-u.

Sorry but I've not the time to learn that format (nor the will), especially 
since patches with -u provide more info both to "patch" and to patch readers.
>  Thanks,
>  Nelson.-

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
