Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D2SA2-0002kA-6N for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Feb 2005 02:48:30 -0800
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D2SA0-00016Z-Hk for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Feb 2005 02:48:30 -0800
Subject: Re: [uml-devel] Re: [PATCH] uml: support a separate build tree;
	support USER_OBJS dependencies
References: <opsl43d9yilfdzum@localhost.localdomain>
	<200502132151.j1DLoxnW003492@ccure.user-mode-linux.org>
	<opsl5r02lclfdzum@localhost.localdomain>
	<200502161930.55206.blaisorblade@yahoo.it>
From: "Vadim Abrossimov" <vadim_abrossimov@yahoo.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <opsmfxytsflfdzum@localhost.localdomain>
In-Reply-To: <200502161930.55206.blaisorblade@yahoo.it>
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
Date: Sat, 19 Feb 2005 11:55:31 +0100
To: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Wed, 16 Feb 2005 19:30:54 +0100, Blaisorblade <blaisorblade@yahoo.it>  
wrote:

> Ok, I have two more requests, if possible:
> 1) add something like arch/um/Rules.make which is included everywhere  
> needed
> 2) There is an error in the patch (even in Al's idea): you must swap, in  
> the below code

OK. I will do it.
Against which version you would suggest me to do it:
- as an add-on to 2.6.11-rc3-mm2 + Jeff's tarball (which already includes  
the original USER_OBJ cleanup)
- 2.6 bk
- any other

Also I have more general questions about the usual way the uml community  
works:
- do the patches from Jeff's tarball are intended to be pushed in 2.6 BK?  
if yes when and how?
- if one propose a patch against which version he/she should do it in  
order to (1) be useful for the community (2) get the patch pushed in 2.6  
BK soon? (Presumably (1) and (2) have the same answer :->)

Dima


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
