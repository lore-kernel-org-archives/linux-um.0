Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWJNk-0005R5-Dx
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Dec 2003 09:53:16 -0800
Received: from [62.94.208.107] (helo=mancillotti.retesintesi.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWJNj-0000uo-JA
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Dec 2003 09:53:16 -0800
Subject: Re: [uml-devel] uml-patch-2.4.22-7
From: marco ancillotti <mancillotti@interfree.it>
In-Reply-To: <200312161653.hBGGrDkS002312@ccure.user-mode-linux.org>
References: <200312161653.hBGGrDkS002312@ccure.user-mode-linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1071597053.2150.9.camel@mancillotti.retesintesi.net>
Mime-Version: 1.0
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: 16 Dec 2003 18:50:53 +0100
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

> 	highmem support is back - it seems to work, but I haven't banged on
> it to much.  

no problem jeff , I will test i hardly for you ;-)

> One caveat is that using highmem in skas mode is very slow because
> of the need to do kmapping in the copy_user routines.

so there's better performance in tt mode when using highmem ?

bye.


-- 
----------------------------------------------------

Marco Ancillotti 
uniX / Linux Tecnical specialist

- IBM Aix Certified Advanced Tecnical Specialist
- IBM Enterprise storage specialist
- Red Hat Certified Engineer

    Lpar manager first developer and mantainer.
( http://savannah.nongnu.org/projects/lparmanager )

S.in.te.si. srl
via cecchi 28
50053 Empoli (FI)
tel: 0571/72400
fax: 0571/72064

m.ancillotti@retesintesi.it
cell: 347/3460086

----------------------------------------------------


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
