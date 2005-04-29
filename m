Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRFeN-000120-HJ	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 13:30:19 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DRFeK-0003PH-E1	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 13:30:19 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [patch 1/7] uml: fix syscall table by including
	$(SUBARCH)'s one, for i386
References: <20050424181909.81B8F33AED@zion>
	<20050428181053.GQ23013@shell0.pdx.osdl.net>
In-Reply-To: <20050428181053.GQ23013@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504292231.18763.blaisorblade@yahoo.it>
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
Date: Fri, 29 Apr 2005 22:31:18 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org, jdike@addtoit.com, bstroesser@fujitsu-siemens.com, linux-kernel@vger.kernel.org

On Thursday 28 April 2005 20:10, Chris Wright wrote:
> * blaisorblade@yahoo.it (blaisorblade@yahoo.it) wrote:
> > Split the i386 entry.S files into entry.S and syscall_table.S which
> > is included in the previous one (so actually there is no difference
> > between them) and use the syscall_table.S in the UML build, instead of
> > tracking by hand the syscall table changes (which is inherently
> > error-prone).
>
> Xen can use this as well (it was on my todo list).
Yes, I had this idea too. So I guess this will be promptly merged, right?

-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
