Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CTx2Q-0002Vs-6I for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Nov 2004 22:42:02 -0800
Received: from pimout3-ext.prodigy.net ([207.115.63.102])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CTx2P-0004af-Aw for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Nov 2004 22:42:02 -0800
From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [uml-devel] [PATCH] uml: fail xterm_open when we have no $DISPLAY
Message-ID: <20041116064151.GB22588@taniwha.stupidest.org>
References: <20041115032541.GA13077@taniwha.stupidest.org>
	<200411151824.29365.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411151824.29365.blaisorblade_spam@yahoo.it>
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
Date: Mon, 15 Nov 2004 22:41:51 -0800
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>

On Mon, Nov 15, 2004 at 06:24:29PM +0100, Blaisorblade wrote:

> Thanks for drawing attention on this! I hadn't had the time to dig
> this out...  for now reasonably correct

it's a partial solution, in general more is required

> but no time to review it properly now. The review would probably try
> to find a more direct fix to this...

catch the xterm process dying, up(&data->sem), and -EIO all requests
from that point onwards I guess.  That applies for some of the other
channels too, some of the code would probably be abstracted a little
and generalized I guess.



   --cw


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
