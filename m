Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ArPvi-0000Q9-4T
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 15:07:34 -0800
Received: from erizo.shearer.org ([210.10.97.33] helo=shearer.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.30)
	id 1ArPuK-000556-Cm
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 15:06:08 -0800
From: Dan Shearer <dan@shearer.org>
Subject: Re: [uml-devel] Which UPS simulator?
Message-ID: <20040212230844.GV4203@erizo.shearer.org>
References: <20040212052823.GA4203@erizo.shearer.org> <20040212150023.GA32317@bakunin.copyleft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20040212150023.GA32317@bakunin.copyleft.de>
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
Date: Fri, 13 Feb 2004 09:38:44 +1030
To: Michael Koehne <kraehe@copyleft.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Feb 12, 2004 at 04:00:23PM +0100, Michael Koehne wrote:
> Moin Dan Shearer,
> 
>   why UPS simulation ? I'm using normal mconsole cad feature to power
>   down my UMLs. I only have to ensure that the inittab will trigger a
>   halt with "ca:12345:ctrlaltdel:/sbin/shutdown -t1 -a -h now" instead
>   of rebooting. I then have some helpfull scripts.

That is exactly what I want to avoid. I want a more accurate UML where
no UML-specific logic is needed for communication -- from one point of
view that is what communication is all about. There are plenty of ways
of introducing new communications methods (such as you have done, or a
special listening port, etc) into the UML. 

-- 
Dan Shearer
dan@shearer.org


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
