Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DEQ8n-0002Cq-5a for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Mar 2005 03:04:41 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DEQ8l-0008Jc-8V for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Mar 2005 03:04:40 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: BUG with proposed fix Re: [uml-devel] Can't compile under vanilla
	2.6.11
References: <cbec11ac05031719187cb8e7d2@mail.gmail.com>
	<cbec11ac05032020433867d95e@mail.gmail.com>
	<cbec11ac05032021301a9083f7@mail.gmail.com>
In-Reply-To: <cbec11ac05032021301a9083f7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503241203.57593.blaisorblade@yahoo.it>
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
Date: Thu, 24 Mar 2005 12:03:57 +0100
To: user-mode-linux-devel@lists.sourceforge.net, Ian McDonald <imcdnzl@gmail.com>
Cc: Rob Landley <rob@landley.net>

On Monday 21 March 2005 06:30, Ian McDonald wrote:
> The other problem with not linking va_copy has been resolved by
> changing to __va_copy in skas/uaccess.c. This seems to be a known
> problem with older compilers and there is a patch out there but not in
> 2.6.11 or by the looks of it 2.6.12 rc1 by my reading of the log (nor
> for one for my previous e-mail)
Ok, I'm taking that patch and merging it in my tree and in 2.6.12. I hope it 
can go also in 2.6.11.6 (or .7, whatever).

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
