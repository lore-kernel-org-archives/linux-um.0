Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AqMUi-0000sX-KM
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 09 Feb 2004 17:15:20 -0800
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AqMUi-0006nP-3s
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 09 Feb 2004 17:15:20 -0800
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1AqMUg-0006fh-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 10 Feb 2004 02:15:18 +0100
Received: from p508a5511.dip.t-dialin.net ([80.138.85.17])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <user-mode-linux-devel@lists.sourceforge.net>; Tue Feb 10 01:15:18 2004
Received: from skoehler by p508a5511.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <user-mode-linux-devel@lists.sourceforge.net>; Tue Feb 10 01:15:18 2004
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Message-ID: <c09bb2$42o$1@sea.gmane.org>
References: <20040204173846.7522.qmail@praize.com> <200402071702.18101.blaisorblade_spam@yahoo.it> <c08jmp$j7c$1@sea.gmane.org> <200402092021.48547.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <200402092021.48547.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: UML & 2.6.2
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
Date: Tue, 10 Feb 2004 02:10:57 +0100
To: user-mode-linux-devel@lists.sourceforge.net

>>well, i tried to apply it to 2.6.2 vanilla and it doesn't apply without
>>errors. in particular hunk #3 for mm/memory.c fails :-(
>>
>>i know that i have to ignore errors for files in arch/um.
>>
>>so i tried to apply the rejected hunk manually to mm/memory.c but it
>>seems that this section (lines 725 and beyond) is already patched. can
>>somebody take a look at that section and tell me if in_gate_area() is OK
>>there?
> 
> You must unapply all the hunks for mm/memory.c for 2.6.2. Unapply the patch or 
> use a clean source tree, then before applying the patch remove (by hand 
> editing) the whole section about mm/memory.c. The --- and +++ name the file 
> the following lines refer to. Also, remember using patch --dry-run to check 
> before applying what rejects appear, since with --dry-run patch doesn't 
> modify the patched files.

OK, i will try it again.



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
