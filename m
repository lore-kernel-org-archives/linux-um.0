Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAr0W-00043X-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 18 Oct 2003 06:20:36 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1AAr0U-0001Pd-Jg
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 18 Oct 2003 06:20:34 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Hardening hostfs
References: <Pine.LNX.4.44.0310180026300.22559-100000@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.44.0310180026300.22559-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310181522.31529.blaisorblade_spam@yahoo.it>
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
Date: Sat, 18 Oct 2003 15:22:31 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Alle 00:35, sabato 18 ottobre 2003, Henrik Nordstrom ha scritto:
> On Thu, 16 Oct 2003, Doug Dumitru wrote:
> > 1.  If hostfs is compiled in as a module, then the hostfs=...
> > command-line arguments are not used.  Thus, trying to restrict access
> > with this does not appear to be effective.
>
> There should be a module argument in this case.. but it seems there is no
> module arguments for the hostfs options..
As noted by Steve Schmidtke, in answer to a patch I posted about a different 
problem, you cannot make this an option for the module. If inside the Uml you 
have root access, you can even omit the option when you load the module(and 
to call mount you must be root anyway). So, the only right behaviour is to 
make the module read the option supplied at boot time.

IIRC, in the approaching 2.6 mainline kernel there is something for this 
purpose(I remember an article on LWN about module infrastructure changes), 
but I only have a very vague idea.

One solution which would work even now is to move the __uml_setup code 
somewhere else, and to make it conditional to CONFIG_HOSTFS(or whatever name 
it has): the macro is defined both if it's compiled as a module and if it's 
compiled statically. Then the actual module would read the external variable.
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
