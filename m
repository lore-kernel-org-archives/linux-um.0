Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnkoL-008QCV-OI
 for linux-um@lists.infradead.org; Thu, 18 Nov 2021 17:02:59 +0000
Received: by mail-wr1-x42c.google.com with SMTP id r8so12864405wra.7
 for <linux-um@lists.infradead.org>; Thu, 18 Nov 2021 09:02:57 -0800 (PST)
MIME-Version: 1.0
References: <202111180219.YkyoBMpf-lkp@intel.com>
 <CANn89iJfh+x-s4GtWJcyRFpMmSvvyq-r1TGV4sDLXy3F50zD6w@mail.gmail.com>
 <CANn89iJj4zeNUiXCmG=rSejbHAwPhBEPKUv1tPL9ig=e4vg7pQ@mail.gmail.com>
 <YZZ4upqWGMOY+r56@hirez.programming.kicks-ass.net>
 <21f86e2bc817b6ec0c7a9194a4fefb1d55e3040b.camel@sipsolutions.net>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
In-Reply-To: <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Nov 2021 09:02:43 -0800
Message-ID: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Peter Zijlstra <peterz@infradead.org>, kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org, linux-kernel@vger.kernel.org, x86@kernel.org, Alexander Duyck <alexanderduyck@fb.com>, linux-um@lists.infradead.org

On Thu, Nov 18, 2021 at 8:57 AM Eric Dumazet <edumazet@google.com> wrote:

>
> Unless fixups can be handled, the signature of the function needs to
> be different.
>
> In UM, we would need to provide a number of bytes that can be read.

We can make this a bit less ugly  of course.

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index 5ec35626945b6db2f7f41c6d46d5e422810eac46..7a3c4e7e05c4b21566e1ee3813a071509a9d54ff
100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -21,6 +21,25 @@ static inline unsigned short from32to16(unsigned a)
        return b;
 }

+
+static inline unsigned long load_partial_long(const void *buff, int len)
+{
+#ifndef CONFIG_DCACHE_WORD_ACCESS
+               union {
+                       unsigned long   ulval;
+                       u8              bytes[sizeof(long)];
+               } v;
+
+               v.ulval = 0;
+               memcpy(v.bytes, buff, len);
+               return v.ulval;
+#else
+               unsigned int shift = (sizeof(long) - len) * BITS_PER_BYTE;
+
+               return (load_unaligned_zeropad(buff) << shift) >> shift;
+#endif
+}
+
 /*
  * Do a checksum on an arbitrary memory area.
  * Returns a 32bit checksum.
@@ -91,11 +110,9 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
                        : "memory");
                buff += 8;
        }
-       if (len & 7) {
-               unsigned int shift = (8 - (len & 7)) * 8;
-               unsigned long trail;
-
-               trail = (load_unaligned_zeropad(buff) << shift) >> shift;
+       len &= 7;
+       if (len) {
+               unsigned long trail = load_partial_long(buff, len);

                asm("addq %[trail],%[res]\n\t"
                    "adcq $0,%[res]"

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

