Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E4bxq-00058C-F3	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Aug 2005 03:13:06 -0700
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1E4bxo-00049Q-Rx
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Aug 2005 03:13:06 -0700
Message-ID: <43006AA6.1040405@yahoo.com.au>
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
References: <20050812182145.DF52E24E7F3@zion.home.lan>
	<20050815104022.D19811@flint.arm.linux.org.uk>
In-Reply-To: <20050815104022.D19811@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [patch 18/39] remap_file_pages protection support:
	add VM_FAULT_SIGSEGV
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
Date: Mon, 15 Aug 2005 20:12:54 +1000
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: blaisorblade@yahoo.it, akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, mingo@elte.hu

Russell King wrote:
> On Fri, Aug 12, 2005 at 08:21:45PM +0200, blaisorblade@yahoo.it wrote:
> 
>>@@ -632,10 +632,11 @@ static inline int page_mapped(struct pag
>>  * Used to decide whether a process gets delivered SIGBUS or
>>  * just gets major/minor fault counters bumped up.
>>  */
>>-#define VM_FAULT_OOM	(-1)
>>-#define VM_FAULT_SIGBUS	0
>>-#define VM_FAULT_MINOR	1
>>-#define VM_FAULT_MAJOR	2
>>+#define VM_FAULT_OOM		(-1)
>>+#define VM_FAULT_SIGBUS		0
>>+#define VM_FAULT_MINOR		1
>>+#define VM_FAULT_MAJOR		2
>>+#define VM_FAULT_SIGSEGV	3
>> 
>> #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
>> 
> 
> 
> Please arrange for "success" values to be numerically larger than "failure"
> values.  This will avoid breaking ARM.
> 
> Is there a reason why we don't use -ve numbers for failure and +ve for
> success here?
> 

Well there is now, and that is we are now using a bit in the 2nd
byte as flags. So I had to do away with -ve numbers there entirely.

You could achieve a similar thing by using another bit in that byte
#define VM_FAULT_FAILED 0x20
and make that bit present in VM_FAULT_OOM and VM_FAULT_SIGBUS, then
do an unlikely test for that bit in your handler and branch away to
the slow path.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
