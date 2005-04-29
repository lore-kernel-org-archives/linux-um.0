Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRFwu-0002Kb-6S	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 13:49:28 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DRFws-000485-GV	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 13:49:28 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] UML-patches to prepare UML/s390
References: <4253E3D6.2000809@fujitsu-siemens.com>
	<200504171937.05846.blaisorblade@yahoo.it>
	<426E2688.1050203@fujitsu-siemens.com>
In-Reply-To: <426E2688.1050203@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200504292250.32383.blaisorblade@yahoo.it>
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
Date: Fri, 29 Apr 2005 22:50:32 +0200
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Tuesday 26 April 2005 13:31, Bodo Stroesser wrote:
> Blaisorblade wrote:
> > Other issues follow, which refer to copied code going out-of-date wrt. my
> > local tree (which I have snapshotted some time ago, after I started
> > writing this mail). This is the problem with copying code - and you're
> > starting experiencing it!
> >
> > * important changes for TLS support, clone(), and so on.
>
> I'm going to implement TLS support in UML/s390. I could do this in
> arch/um/sys-s390/syscalls.c/sys_clone() without any need to change generic
> UML code.
> But I guess, for i386 there will be a need for arch-specific code in
> copy_thread(), maybe something like arch_copy_thread().
> If so, s390 TLS support should be inserted using in the same manner.
> Do you already have some code for this, that I could base on?

On my web-site I've uploaded my personal devel-tree snapshot against -rc3. 
Currently I've had to add a "clear_flushed_tls()" to copy_thread(), which 
probably should be wrapped in a arch_copy_thread() (with a macro/inline in 
some header).

As a side note: the TLS code currently does not work yet, so don't rely on it. 
There are also some issues to (later?) consider, which are indicated in the 
patch itself; and there will be something to add to the host SKAS patch, 
because the current implementation would be a bit too slow probably.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
