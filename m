Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: clean up and streamline probe_kernel_* and friends v2
Date: Wed, 13 May 2020 18:00:20 +0200
Message-Id: <20200513160038.2482415-1-hch@lst.de>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Masami Hiramatsu <mhiramat@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-parisc@vger.kernel.org, netdev@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org

Hi all,

this series start cleaning up the safe kernel and user memory probing
helpers in mm/maccess.c, and then allows architectures to implement
the kernel probing without overriding the address space limit and
temporarily allowing access to user memory.  It then switches x86
over to this new mechanism by reusing the unsafe_* uaccess logic.

This version also switches to the saner copy_{from,to}_kernel_nofault
naming suggested by Linus.

I kept the x86 helprs as-is without calling unsage_{get,put}_user as
that avoids a number of hard to trace casts, and it will still work
with the asm-goto based version easily.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

