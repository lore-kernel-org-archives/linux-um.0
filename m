Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAz6z-0007Qp-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 18 Oct 2003 14:59:49 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1AAz6T-0003cV-N2
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 18 Oct 2003 14:59:17 -0700
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] Hardening hostfs
In-Reply-To: <200310181522.31529.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.44.0310182348320.658-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 18 Oct 2003 23:56:07 +0200 (CEST)
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, 18 Oct 2003, BlaisorBlade wrote:

> As noted by Steve Schmidtke, in answer to a patch I posted about a different 
> problem, you cannot make this an option for the module. If inside the Uml you 
> have root access, you can even omit the option when you load the module(and 
> to call mount you must be root anyway). So, the only right behaviour is to 
> make the module read the option supplied at boot time.

I don't see the point really from a security perspective, as if you can
load modules you can just load whatever module you like doing whatever you
like (or don't like). Nothing guarantees it is this hostfs module which
checks the kernel command line.

The only valid use of the hostfs root dir option is to protect the
administrator within the UML from making stupid mistakes or to simply life
when the UML data is all isolated in a subtree on the host, it should not
be viewed a security option providing security for the host, at least not 
without additional measures taken as discussed elsewhere in this thread.

Only on a strengthened UML where module loading is probidited and root
does not have permission to access the kernel is this option of any
security value for the host, and even then it can just as well be a plain
module argument if hostfs is a module. The hostfs module then obviously
needs to be loaded by controlled startup scripts within the UML before it
is locked down from root, just as is the case for any other module on a
secured and strengthened system.

Regards
Henrik



-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
