Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPNrr-0001xr-Dk for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 08:20:15 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CPNrq-0006el-CP for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 08:20:15 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: Stop at startup on 2.6 NPTL hosts
References: <20041029092641.8558.qmail@web26102.mail.ukl.yahoo.com>
	<41884ACC.2020309@vgertech.com> <878y9jib8z.fsf@bytesex.org>
In-Reply-To: <878y9jib8z.fsf@bytesex.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411031659.56887.blaisorblade_spam@yahoo.it>
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
Date: Wed, 3 Nov 2004 16:59:56 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>, Nuno Silva <nuno.silva@vgertech.com>

On Wednesday 03 November 2004 09:32, Gerd Knorr wrote:
> Nuno Silva <nuno.silva@vgertech.com> writes:
> > Yes, maybe it was me and, FWIW, I never found a solution to make a
> > dynamic skas uml run under 2.6+libcNTPL.
>
> The usual workaround for any nptl issues works here as well:
> export LD_ASSUME_KERNEL=2.4.21
You mean 2.4.1 IIRC, right? However, that does not work on LinuxFromScratch 
and Gentoo systems, mostly, which miss a non-NPTL glibc version.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
