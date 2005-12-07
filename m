Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ek1yo-0000Ma-3W for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Dec 2005 08:17:18 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Ek1yl-0003Lp-8y
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Dec 2005 08:17:18 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] um: fix compile error for tt
References: <1133900650.3279.9.camel@localhost>
	<200512071038.04958.blaisorblade@yahoo.it>
	<Pine.LNX.4.58.0512071538230.22525@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0512071538230.22525@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512071716.08637.blaisorblade@yahoo.it>
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
Date: Wed, 7 Dec 2005 17:16:05 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, akpm@osdl.org, linux-kernel@vger.kernel.org, jdike@karaya.com

On Wednesday 07 December 2005 14:39, Pekka J Enberg wrote:
> Hi,
>
> On Wed, 7 Dec 2005, Blaisorblade wrote:
> > Ok, fine, just a note - the header inclusion should be added to
> >
> > arch/um/include/um_uaccess.h
> >
> > where it is effectively used (the offending macros, using FIXADDR_USER_*,
> > are __access_ok_vsyscall.
> >
> > For the rest it's ok.
>
> Here's an updated patch.

ACK - Andrew, please merge (and queue for -linus), or notify if it needs to be 
resent. Thanks.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
