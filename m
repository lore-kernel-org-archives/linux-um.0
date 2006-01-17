Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eyreh-0000i6-GE for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 06:17:51 -0800
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Eyree-0005S0-RV
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 06:17:51 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 9/11] UML - Implement soft interrupts
References: <200601152139.k0FLdp1G027747@ccure.user-mode-linux.org>
	<200601170124.32076.blaisorblade@yahoo.it>
	<20060117033227.GB17171@ccure.user-mode-linux.org>
In-Reply-To: <20060117033227.GB17171@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601171517.38199.blaisorblade@yahoo.it>
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
Date: Tue, 17 Jan 2006 15:17:37 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org

On Tuesday 17 January 2006 04:32, Jeff Dike wrote:
> On Tue, Jan 17, 2006 at 01:24:31AM +0100, Blaisorblade wrote:
> > ~25 %? Good! Which is delay vs. host?
>
> Delay vs a UML without the patch.
>
> > A curiosity - did you look at the similar code in Ingo Molnar's VCPU
> > patch? I never found the time to split it out and compare differencies. I
> > just remember it using assembler inserts for (maybe atomic) bitmask
> > manipulations.
>
> It was separate from VCPU,
conceptually, but I got only a blob comprising everything - never seen it 
splitout (or maybe I split that out and forgot?)

> but I never really looked at it since I already 
> had this.  Some day I will to see if there are any trick in it that I
> should use.

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
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
