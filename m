Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ABC3E-0006qU-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 19 Oct 2003 04:48:48 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1AAvv9-0008Hv-VT
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 18 Oct 2003 11:35:24 -0700
From: Dan Aloni <da-x@gmx.net>
Message-ID: <20031018183128.GA22119@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] Problem with UML cross compilation
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
Date: Sat, 18 Oct 2003 20:31:28 +0200
To: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

Hi,

Lately I have found a problem with UML and cross compilation. Cross 
compilation means that the architecture that the UML kernel will 
run on (target) is different than the one that it is compiled on 
(host). 

I attempted cross compilation and found that some utils are being
built and run during the build process. These utils were compiled
using the target compiler, which obviously didn't work (all which 
is run on the host needs to be compiled with HOSTCC instead of CC).
Fixing the Makefiles fixes the build procedure from breaking, 
however, the problem is that there is no gaurantee that the UML 
kernel that was built would work.

The reason for the problem is that those utils generate code that
depends on things like offsets inside structs, which obviously 
change between architectures that have different word size. 
It also relies on the target's libc headers, for that purpose.

I've discussed with Jeff about this problem in private E-Mail,
we both thought about solutions but didn't share them yet.

My solution is:

 * Let not build and run those utils on the build host, obviously.
 * All the required versions of the generated code for each of the
   targets will already reside in the tree, the build process will
   automatically pick up the right version and symlink to it.
 * Create a completely standalone program that embeds those utils 
   and generates the code. People who port UML to other 
   architectures will take this program, compile and run it on
   the target and put its output(s) in the tree.
   
The main problem with this method is when and if the target 
changes in such a way that requires those outputs to be 
regenerated. 

I would like your suggestions and opinions about how feasible 
this solution with the 2.4 and 2.6 trees, and if you have
other solutions I'd like to know.

Thanks,

-- 
Dan Aloni
da-x@gmx.net


-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
