Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPoBZ-0001PS-PS for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 12:54:05 -0700
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BPoBZ-0006sA-4t for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 12:54:05 -0700
Message-ID: <029401c43c49$a97fca20$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.44.0405172036290.20517-100000@filer.marasystems.com>
Subject: Re: [uml-devel] CVS not updated?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Mon, 17 May 2004 22:00:47 +0200
To: Henrik Nordstrom <uml@hno.marasystems.com>, user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

hi!
what about the 2.6 (uml)kernel ?
how is revision control being made there (or not?) ?

maybe someone take a look at: http://rockbox.haxx.se/ ?
that is what i would expect for a really good source/bug/patch-management. i like that project very much because of that - recent
cvs activity, daily changelogs, automatic builds.... :)
sorry - i`m no developer so i cannot decide - but something like this is what i really would like - so everybody could see, how
things in UML are going on....

> > The more I look at the CVS tree the more confused I get.. what is
> > actaually in the CVS at the moment? Looks like something like the current
> > patch but based on 2.4.23 instead of 2.4.26..
???
when i look at:
http://www.user-mode-linux.org/cvs/linux/
there are log entries "updated to 2.4.26".

there is a sourceforge-cvs-repository, too:
http://cvs.sourceforge.net/viewcvs.py/user-mode-linux/linux/,
which looks quite different.

so - which is the right one ?

regards
roland



----- Original Message ----- 
From: "Henrik Nordstrom" <uml@hno.marasystems.com>
To: <user-mode-linux-devel@lists.sourceforge.net>
Sent: Monday, May 17, 2004 8:59 PM
Subject: Re: [uml-devel] CVS not updated?


> On Mon, 17 May 2004, Henrik Nordstrom wrote:
>
> > The more I look at the CVS tree the more confused I get.. what is
> > actaually in the CVS at the moment? Looks like something like the current
> > patch but based on 2.4.23 instead of 2.4.26..
>
> Digging.. and there is some conclusions
>
> a) The CVS tree currently seems to be 2.4.24-2
>
> b) The CVS tree contains many deleted files which for some reason has not
> been deleted in the CVS, some of which are very old, and most even have
> tag versions of the newer patches even if they are not included in the
> patches.
>
> Or bottom line, the CVS tree is pretty much not suitable as source when
> building kernels, just a version repository to look into what changed when
> and only for kernels up to 2.4.24-2, and even then quite confusing due
> to the duplicate files on rearrangements.
>
> Regards
> Henrik
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: SourceForge.net Broadband
> Sign-up now for SourceForge Broadband and get the fastest
> 6.0/768 connection for only $19.95/mo for the first 3 months!
> http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
