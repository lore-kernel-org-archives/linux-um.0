Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZW1G-0005SU-50 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 08:08:22 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EZW1F-0006PO-C6
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 08:08:21 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 8/10] UML - Maintain own LDT entries
References: <200510310439.j9V4dfbw000872@ccure.user-mode-linux.org>
	<200511072028.23111.blaisorblade@yahoo.it>
	<4370C36E.2040205@fujitsu-siemens.com>
In-Reply-To: <4370C36E.2040205@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511081702.02891.blaisorblade@yahoo.it>
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
Date: Tue, 8 Nov 2005 17:02:02 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Allan Graves <allan.graves@oracle.com>

On Tuesday 08 November 2005 16:25, Bodo Stroesser wrote:
> Blaisorblade wrote:
> > On Monday 07 November 2005 13:20, Bodo Stroesser wrote:
> >>Blaisorblade wrote:
> >>>On Monday 31 October 2005 05:39, Jeff Dike wrote:
> >>>>From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

> In my opinion there is no reason to change the current implementation for
> SAKS3/0. Note: if someone reads LDT via [sys_]modify_ldt(), he will receive
> the requested data in "processor format", that is LDT-descriptors. He will
> receive a list of descriptors starting at the first descriptor of the LDT,
> thus no entry number is needed in the enties.
Ehrr... ACK! You're right, I really _did_ miss the read_ldt case.
> The only case that uses user_desc is when writing one desriptor via
> modify_ldt(). modify_ldt(WRITE) exactly writes one LDT-descriptor, so
> user_desc must contain the number of the entry to write. Thus user_desc is
> bigger than LDT descriptor. It also uses an other data layout resulting in
> double the size of LDT-descriptor. So I think it doesn't make sense to
> store user_desc. We save memory storing the resulting LDT-descriptors,
> which then are copied transparently on modify_ldt(READ). Conversion between
> user_desc and LDT-entry is done on modify_ldt(WRITE) in SKAS0 only. No
> other conversions are done in UML.

Ok, I now totally agree with your point. I had missed the read_ldt case. It's 
perfectly fine to keep it as-is.
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
