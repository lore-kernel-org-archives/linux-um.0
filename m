Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZCa2-0000F6-Uc for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Nov 2005 11:22:58 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EZCa0-0004Zp-9g
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Nov 2005 11:22:58 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 8/10] UML - Maintain own LDT entries
References: <200510310439.j9V4dfbw000872@ccure.user-mode-linux.org>
	<200511022051.24335.blaisorblade@yahoo.it>
	<436F469B.3080607@fujitsu-siemens.com>
In-Reply-To: <436F469B.3080607@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511072028.23111.blaisorblade@yahoo.it>
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
Date: Mon, 7 Nov 2005 20:28:22 +0100
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Allan Graves <allan.graves@oracle.com>

On Monday 07 November 2005 13:20, Bodo Stroesser wrote:
> Blaisorblade wrote:
> > On Monday 31 October 2005 05:39, Jeff Dike wrote:
> >>From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

> > Or at least so I think (I must still give a proper look afterwards, and
> > I'll post patches). Actually it seems that this is done on purpose, but I
> > don't agree too much on this. I will see.

>  From the beginning my new code for SKAS included the checks/buffering you
> later inserted for TT and SKAS. So this patch is a second version adapted
> to your changes. It shifts your improvements into TT path only (where I
> didn't do any changes in my old patch), while it uses my own stuff for
> SKAS. Thus the patch doesn't really revert your improvements, but restricts
> it to TT. As in SKAS0 UML now holds its own LDT data, there is no need for
> buffering in this case. So I think it makes sense to have separate code for
> SKAS.
Yep, ok - I'm undecided about the new code for SKAS3, but it may make sense 
(i.e. no opinion).

Instead, I have another question: is there a proper reason for using the 
processor format for storing the info and translating it back to (struct 
user_desc)? I am planning to avoid this double translation because I don't 
like it. Any opinion?
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
