Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GBzMe-0007fX-56 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Aug 2006 12:41:44 -0700
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GBzMb-0004lQ-Jt
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Aug 2006 12:41:44 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 12 Aug 2006 21:41:45 +0200
References: <f8194a940608110508hee34903kdc134042b5f59b6c@mail.gmail.com>
In-Reply-To: <f8194a940608110508hee34903kdc134042b5f59b6c@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608122141.45315.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] How to submit UML patch?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: QJ Miao <qjmiao@gmail.com>

On Friday 11 August 2006 14:08, QJ Miao wrote:
> Hi,
>
> I have some useful UML patch to submit.
> But I don not know how to do it.

The proper policy is:

*) send it to UML maintainers (i.e. Jeff Dike and me) and this mailing list. 
Experienced developers also CC LKML (i.e. linux-kernel@vger.kernel.org) but 
newcomers should let us filter your ideas - LKML is not very friendly for 
newcomers if they don't follow the rules (but general ones and 

*) make sure to generate an unified diff patch, with -p to show c functions 
names for increased readability (like diff -Npur a/ b/), possibly which 
applies with -p1 (we'll handle failures about -p1, probably not about the 
rest).

*) (possibly) read LKML faq for patch submission for general rules. I suggest 
attaching it with 7-bit encoding (rather than quoted-printable) and 
text/plain MIME type.

Please don't include it in the mail since it only works with text-based MUAs, 
and with very few (if any) graphical MUAs with special care. To do that we 
use special tools in fact.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
