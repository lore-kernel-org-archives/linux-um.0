Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AM93J-0007rc-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 18 Nov 2003 08:50:09 -0800
Received: from stclair.eecs.umich.edu ([141.213.8.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AM93I-0000qL-PU
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 18 Nov 2003 08:50:09 -0800
From: George Washington Dunlap III <dunlapg@umich.edu>
Subject: Re: [uml-devel] University project on UML
In-Reply-To: <1265.141.165.213.235.1069170899.squirrel@email.georgiasouthern.edu>
Message-ID: <Pine.LNX.4.44.0311181126350.25040-100000@stclair.eecs.umich.edu>
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
Date: Tue, 18 Nov 2003 11:50:00 -0500 (EST)
To: "Matthew E. Dugan" <matthew_e_dugan@GeorgiaSouthern.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net

Matthew, your project sounds interesting, but I'm not sure exactly what it
is that you're trying to do.  

So, by 'virtual machine' you mean the arch-um layer which translates host
abstractions (threads, mmap/mprotect/munmap, pipes, files) into hardware
abstractions Linux is used to (processors, physical memory and page
tables, consoles and serial lines, physical disks), is this correct?

And you're going to strip everything down to arch-um, then add various
subsystems back in -- memory subsystem, processes and context-switching, 
device layers, file systems, networking, and so on?

(Because another interpretation of "strip UML down to just a virtual
machine" would be to strip the *host* kernel down to nothing, just enough
to run UML and a handful of other services on top of it; but it doesn't
sound like that's what you're doing.)

And the purpose, in the main, is to pick apart UML and find out how it 
works?  Do you have any other goals or further research in mind?

Our group at the University of Michigan is using UML for research as well 
(nothing related to yours, it looks like), and I'd be interested to see 
what you come up with.

Here's our site:
  http://www.eecs.umich.edu/CoVirt/

All our research thus far has been on UMLinux (now FAUMachine), but I'm 
working on porting it over to UML.

Peace,
 -George


On Tue, 18 Nov 2003, Matthew E. Dugan wrote:

> 
> Good day,
> 
> Today I start working on a Georgia Southern University (located in the
> South-East United States) research project covering User Mode Linux.  The
> professor in charge wants to accomplish the following over the next few
> weeks:
> 
> 1) Strip UML down to a compilable state containing only the virtual machine
> 2) Perform any clean ups and re-organizations
> 3) Take one of the removed pieces, verify its function
> 4) Perform any clean ups and re-organizations on the removed piece
> 5) Add the piece back into the build process
> 6) Repeat steps 3-5 until finished.
> 
> He calls it a "verification process".  At the end of which, he plans to
> publish a paper documenting what we do along with a detailed
> representation of the workings of the UML internals.
> 
> I appreciate the opportunity to participate in this list server, and look
> forward to any recommendations any of you may have for this undertaking.
> 
> Sincerely,
> 
> Matthew Dugan
> mdugan@georgiasouthern.edu
> 
> 
> 
> 
> -------------------------------------------------------
> This SF. Net email is sponsored by: GoToMyPC
> GoToMyPC is the fast, easy and secure way to access your computer from
> any Web browser or wireless device. Click here to Try it Free!
> https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 

-- 
+-------------------+----------------------------------------
| dunlapg@umich.edu | http://www-personal.umich.edu/~dunlapg 
+-------------------+----------------------------------------
| "An empty life of luxury is still an empty life"
|    -- everybodyduck, "Walk the Plank"
+------------------------------------------------------------
| Outlaw Junk Email! Support HR 1748 (www.cauce.org)



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
