Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ct9Hu-0003fZ-Bl for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 10:50:10 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Ct9Hp-00014O-KQ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 10:50:10 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] memory
References: <267988DEACEC5A4D86D5FCD780313FBB03B7317C@exch-03.noida.hcltech.com>
In-Reply-To: <267988DEACEC5A4D86D5FCD780313FBB03B7317C@exch-03.noida.hcltech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501242007.30317.blaisorblade@yahoo.it>
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
Date: Mon, 24 Jan 2005 20:07:30 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "Vaibhav Sharma, Noida" <Vaibhavs@noida.hcltech.com>

On Monday 24 January 2005 09:13, Vaibhav  Sharma, Noida wrote:
> Thank you all for ur valuable discussion (temp dir) and suggestions related
> to highmem/PAE and x86_64.
>
> I have another thing to ask related to debugging...i want to check the
> routines which will be involved in the memory management.
>
> According to the design of UML, it has its own VM system. If I have to
> check the scalability limits of the "parent kernel" for memory management,
> will UML be useful..?

Well, yes, indeed. UML, indeed, has no special way to request memory on the 
host*, so the host kernel must be efficient in managing and swapping UML 
memory. On top of that, using the very same algorithms as any Linux system 
(or better, as that release compiled for another arch), UML manages his own 
memory and splits it between processes, swaps part of it, and so on.

* (if something is thinking to SKAS, it does not account in the discussion - 
that is a different question, which is about implementation details and not 
about the conceptual model, as shown by skas0, i.e. UML running in a 
(limited) SKAS mode without host SKAS support...).

> When I debug the UML kernel when a process requests a large amount of
> memory, I will only get the flow used by UML for its VM. Is the code/design
> of UML very different from the parent kernel..?
The code is the same, but the data they use for their decision are 
different... RAM is passed by the host to UML and by UML to the guest, as 
said above.

> Is there a way in I can get to code of parent kernel when 2G /3G RAM size
> is used?
??? Do you want to understand where the host is limited to 3G for its 
applications? I don't think you want this... the exact point is the TASK_SIZE 
macro, which is configurable somehow... however you must be careful...

If you leave 512 M to the kernel and 3,5G to the userspace, all the memory 
above 512M will be slower... Actually, it's 512 - 128 M at least (the kernel 
part of the 4G of virtual address space must map physical RAM, AND host some 
virtual mappings, i.e. 128M of vmalloc()ed memory).

You'd probably prefer to use the 4G/4G patch from Ingo Molnar, integrated into 
Fedora kernels, to allow processes to use 4G of virtual address space.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
