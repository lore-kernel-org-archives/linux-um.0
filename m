Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CkpZh-0006pw-8r for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 01 Jan 2005 12:10:09 -0800
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CkpZb-0003oO-Ch for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 01 Jan 2005 12:10:09 -0800
Message-ID: <0e6601c4f03e$00c69770$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <200412140958.58402.Armin.Warda@ePost.De>
	<200412301520.48951.Armin.Warda@gmx.de>
	<E54DD071-5A7D-11D9-853A-0003931D03FE@theshore.net>
	<200412311222.10579.Armin.Warda@gmx.de>
Subject: Re: [uml-devel] Re: UML fills /tmp irreversibly (2.6.9-bb4 on SuSE
	9.2)
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
Date: Sat, 1 Jan 2005 14:10:45 -0600
To: Armin.Warda@gmx.de, user-mode-linux-devel@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>

> That's supposed to be a 2.6.10 _Host_-Kernel? (Not 2.6.10 UM-Kernel?)

Correct.

>> The tmpfs problem is also  
>> compounded by the fact that UMLs without the fix-kill patch don't
>> exit properly, but the 2.6.9-bb4 patchset has the fix for UML.

> You say UM-Kernel 2.6.9-bb4 has that fix? (Yes, I am running 2.6.9-bb4 
> UM-Kernels)

Correct.

>> For 2.4-um, you can find the fix-kill patch here:
>> http://www.theshore.net/~caker/uml/patches/2.4.27-1um/

-Chris


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
