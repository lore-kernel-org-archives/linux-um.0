Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FJ8fJ-0000bK-NM for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Mar 2006 04:30:17 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FJ8fG-0004mO-QE
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Mar 2006 04:30:17 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Host crash on find from UML (was: Re: [uml-devel] mount hostfs
	problem)
References: <565F40B9893580489B94B8D324460AF4572AA4@zmy16exm63.ds.mot.com>
In-Reply-To: <565F40B9893580489B94B8D324460AF4572AA4@zmy16exm63.ds.mot.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603141330.00351.blaisorblade@yahoo.it>
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
Date: Tue, 14 Mar 2006 13:29:59 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Wang LianWei-A22439 <lian-wei.wang@motorola.com>

On Tuesday 14 March 2006 08:57, Wang LianWei-A22439 wrote:
> After launch the uml with hostfs mounted, I run the find command in '/'
> directory,then the host system crash.

I know of such a *host* bug in host 2.4 kernels, which was fixed in (around) 
2.4.25. If you have such a host kernel, upgrade it. It's an host bug anyway.

> as below procedure:
>
>        cd /
>        find .
> then the host crash.
>
> My UML kernel version is 2.6.10.
>
> Best Regards,
> Wang Lianwei
> [X]  General Business Information

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
