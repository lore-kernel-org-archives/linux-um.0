Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CbgAG-0006Lf-Ue for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Dec 2004 06:18:04 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CbgAF-00069w-H4 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Dec 2004 06:18:04 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] 2.6.9 slow
References: <1102404966.17303.71.camel@debian>
In-Reply-To: <1102404966.17303.71.camel@debian>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412071521.53205.blaisorblade_spam@yahoo.it>
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
Date: Tue, 7 Dec 2004 15:21:52 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Hegedus Gabor <hygylista@freemail.hu>

On Tuesday 07 December 2004 08:36, Hegedus Gabor wrote:
> Hi!
>
> I tested 2.6.9 with patched with host-skas3-2.6.9-v7.patch. It is very
> slow, but there is not a big load, nor a big disk io. (I checkd with
> iostat)

> With 2.6.7 it is good.
With SKAS or vanilla? I assume it's vanilla - might you try that with SKAS?

> bye
>  HyGy
Well, basically SKAS is unlikely to cause that... I'd rather think that in 
your config 2.6.9 is slower than 2.6.7. Check if you've changed anything 
relevant on the kernel config.

To make sure that SKAS is not at fault:

- if it becomes slow after running some UMLs, then SKAS is probably at fault. 
Not otherwise.

- also, I guess that you'll have the performance hit even without SKAS patch 
applied. Make sure not to change the kernel configuration!
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
