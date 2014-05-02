Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stian@nixia.no>) id 1Wg7GA-0007XX-F9
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 May 2014 06:47:50 +0000
Received: from [195.159.66.51] (helo=ramslauken.nlc.no)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wg7G8-0006Zz-Dv for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 May 2014 06:47:50 +0000
Received: from mail.polarparty.no (ramslauken.nlc.no [195.159.66.51])
	(Authenticated sender: stian@nixia.no)
	by ramslauken.nlc.no (Postfix) with ESMTPA id A6D071D1EE1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri,  2 May 2014 08:43:04 +0200 (CEST)
MIME-Version: 1.0
Date: Fri, 02 May 2014 08:43:04 +0200
From: stian@nixia.no
In-Reply-To: <5362B53E.5060601@nod.at>
References: <53613E96.2030006@gmx.de>
	<CAFLxGvyyMMSajwOtS1O6R-_XnJv7dc_61k3Hx9JJB7nmVLNWng@mail.gmail.com>
	<536221F4.6000405@gmx.de> <53623EFE.3040603@nod.at>
	<5362651A.1020504@gmx.de> <5362B53E.5060601@nod.at>
Message-ID: <dd7386ea80ce1fd3e5a864966b3b5e80@nixia.no>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] trinity commit 23dc478aba breaks syscall "mremap"
 at a 32 bit user mode linux
To: user-mode-linux-devel@lists.sourceforge.net

> Yeah, this is because trinity destroys the UML stub code.
> Please test the attached patch, it should fix the root cause of the 
> problem.

@@ -124,6 +125,9 @@ static int add_munmap(unsigned long addr, unsigned 
long len,
  	struct host_vm_op *last;
  	int ret = 0;

+	if ((addr >= STUB_START) && (addr < STUB_END))
+		return -EINVAL;
+
  	if (hvc->index != 0) {
  		last = &hvc->ops[hvc->index - 1];
  		if ((last->type == MUNMAP) &&

I do not know how add_munmap is called, so this is more of a question. 
What happens in the use cases where the mmap spans multiple pages, and 
the stub is in the middle and other variations?

Should it not check that
a) The start of the MMAP is not within the STUB.
b) The end of the MMAP is within the STUB
c) That the start of the MMAP is not before the STUB and the END is not 
after the STUB


Stian Skjelstad

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

