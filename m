Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AnNep-0000WG-PY
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 01 Feb 2004 11:53:27 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AnNep-0001tF-6j
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 01 Feb 2004 11:53:27 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] sigjmp cleanup patch (2.6)
Message-ID: <20040201201723.GC20413@ccure.user-mode-linux.org>
References: <Pine.LNX.4.58.0402011254480.14738@vega.dur.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402011254480.14738@vega.dur.ac.uk>
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
Date: Sun, 1 Feb 2004 15:17:23 -0500
To: M A Young <m.a.young@durham.ac.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Feb 01, 2004 at 01:03:18PM +0000, M A Young wrote:
> This patch cleans up the code so that the sigsetjmp calls use the correct
> data type (sigjmp_buf rather than jmp_buf). This could fix a potential
> bug, though I don't know of any actual bugs that this fixes. The patch is
> for 2.6, though 2.4 has the same issue also.

Thanks, I thought I got them all.  I applied this to my 2.4 tree - they'll
get merged into my 2.6 tree next time I update it.

				Jeff


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
