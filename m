Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CnuC0-0001wZ-BX for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Jan 2005 23:42:24 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CnuBy-0005SK-QN
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Jan 2005 23:42:24 -0800
Received: from knoppix (grelber.thyrsus.com [192.168.1.31])
	by grelber.thyrsus.com (8.12.11/8.12.11) with ESMTP id j0A8oRbh007647
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 10 Jan 2005 03:50:28 -0500
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] How stable is hostfs (and UML in general)?
References: <200501082106.38306.rob@landley.net>
	<31487.1105315534@marajade.sandelman.ottawa.on.ca>
	<200501100120.04746.rob@landley.net>
In-Reply-To: <200501100120.04746.rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501100141.04892.rob@landley.net>
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
Date: Mon, 10 Jan 2005 01:41:04 -0500
To: user-mode-linux-devel@lists.sourceforge.net

On Monday 10 January 2005 01:20 am, Rob Landley wrote:

> I did, of course, check and make sure that ls and cat and such found ld in
> the UML environment, which they did.  (The error message is actually
> collect2 can't find ld, although apparently gcc can find collect2.)  I
> tried running gcc -v to see if I could get it to tell me what it was doing
> that didn't work (thinking possibly some environment variable was set
> wrong), and uclibc hung so badly I had to kill it from another window.

Ahem: uml is what hung so badly I had to kill it from another window.  
(Possibly just that ctrl-c doesn't work from an fd console.  I've set it up 
like that to be scriptable, but I need to get it to work before I can script 
it...)

I admit I may be hard to understand here.  I'm relatively new to UML, and 
among other things I keep typing "uclibc" when I mean "UML".  (Acronym 
overload, as usual.  Never was that good with names...)

Rob


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
