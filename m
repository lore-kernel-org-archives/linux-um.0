Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mq42w-006Gbw-M7
 for linux-um@lists.infradead.org; Thu, 25 Nov 2021 01:59:36 +0000
Received: by mail-io1-xd34.google.com with SMTP id f9so5588241ioo.11
 for <linux-um@lists.infradead.org>; Wed, 24 Nov 2021 17:59:34 -0800 (PST)
Message-ID: <619eee05.1c69fb81.4b686.4bbc@mx.google.com>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
Date: Wed, 24 Nov 2021 19:58:57 -0600
In-Reply-To: <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
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
To: edumazet@google.com, Johannes Berg <johannes@sipsolutions.net>
Cc: alexanderduyck@fb.com, kbuild-all@lists.01.org, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, lkp@intel.com, peterz@infradead.org, x86@kernel.org, goldstein.w.n@gmail.com

From: Eric Dumazet <edumazet@google.com>

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

Hi, I'm not sure if this is intentional or not, but I noticed that the output
of 'csum_partial' is different after this patch. I figured that the checksum
algorithm is fixed so just wanted mention it incase its a bug. If not sorry
for the spam.

Example on x86_64:

Buff: [ 87, b3, 92, b7, 8b, 53, 96, db, cd, 0f, 7e, 7e ]
len : 11
sum : 0

csum_partial new : 2480936615
csum_partial HEAD: 2472089390

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

