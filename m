Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19vH9i-0006Mr-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 05 Sep 2003 07:01:42 -0700
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19vH9c-0002DE-7q
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Sep 2003 07:01:36 -0700
Received: from 216-15-124-77.c3-0.smr-ubr3.sbo-smr.ma.cable.rcn.com ([216.15.124.77] helo=mizar.alcor.net)
	by smtp01.mrf.mail.rcn.net with esmtp (Exim 3.35 #4)
	id 19vH9M-0004aJ-00
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Sep 2003 10:01:20 -0400
Received: from mdz by mizar.alcor.net with local (Exim 3.36 #1 (Debian))
	id 19vH9L-0007JG-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 05 Sep 2003 10:01:19 -0400
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] hostfs as root
Message-ID: <20030905140119.GM11825@alcor.net>
References: <20030905011050.GD16552@alcor.net> <11307.1062769436@marajade.sandelman.ottawa.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11307.1062769436@marajade.sandelman.ottawa.on.ca>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 5 Sep 2003 10:01:19 -0400
To: user-mode-linux-devel@lists.sourceforge.net

On Fri, Sep 05, 2003 at 09:43:56AM -0400, Michael Richardson wrote:

> 
> >>>>> "Matt" == Matt Zimmerman <mdz@debian.org> writes:
>     Matt> The problem I ran into which led me to this bug was extracting tar
>     Matt> archives. 
>     Matt> When they contain read-only files, tar opens them for writing with
>     Matt> read-only 
>     Matt> permissions.  Since UML was creating the file and then, subsequently,
>     Matt> attempting to open it for writing, the second open failed.
> 
>   How is this the correct thing to do for the UML then?
>   What bug did you uncover?

I described it above.  tar was completely unable to extract files with
read-only permissions.

>     Matt> I think that in general, having the permissions silently changed
>     Matt> would be 
>     Matt> unwise, though I admit that u-r permissions are weird at best.  It
> 
>   Well, if the opener is root, you get to ignore the permissions. That means
> that something has to break.
> 
>   I propose:
>     stat(), save permissions
>     chmod(u+rw) (as appropriate for the open)
>     open()
>     chmod(oldperms)

Sounds like a recipe for lots of race conditions.

>     Matt> would 
>     Matt> seem better to have mount fixed to stop doing this strange thing, and
>     Matt> eventually to emulate full permission control in hostfs.
> 
>   Well, leaving us in a lurch is decidely not friendly.  
>   Your fix has broken debian potato's mount. Being able to run other distros,
> versions, etc. inside of UML is one of the major features of UML.

OK, so mount is already fixed.  So the only problem is that you can't use an
old, mildly buggy version of mount with root-hostfs as a non-root user on
the host.  I'd rather be able to extract tar files than have that scenario.

You must have already worked around some other problems in order to run
potato in this configuration; it wouldn't work out of the box with a 2.4
kernel.  How are you managing device nodes?  Loading any kernel modules?

-- 
 - mdz


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
