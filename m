Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <anishkk1@gmail.com>) id 1NgEND-0004wF-Ey
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Feb 2010 09:33:11 +0000
Received: from mail-px0-f181.google.com ([209.85.216.181])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NgENB-0005D1-0b for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Feb 2010 09:33:11 +0000
Received: by pxi11 with SMTP id 11so2085806pxi.22
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 13 Feb 2010 01:33:01 -0800 (PST)
MIME-Version: 1.0
Date: Sat, 13 Feb 2010 15:03:01 +0530
Message-ID: <e9c371f11002130133n57580ae1xc394c6d9413471c3@mail.gmail.com>
From: Anish K K <anishkk1@gmail.com>
Subject: [uml-devel] Doubt regarding physical address of ioremapped virtual
	address
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
To: user-mode-linux-devel@lists.sourceforge.net

Hi all,

I am using linux 2.6.22.18 kernel running on Marvel Sheeva MV88F6281 board.
I posses a doubt regarding the usage of ioremap.

In the Marvel board there is an XOR/DMA engine.
The DMA engine can be used to move data from SDRAM to SDRAM or from
PCIe to SDRAM.

For DMA Read from PCIe receive buffer,

the DESTINATION is a buffer allocated in kernel space

gReadBuffer = kmalloc(BUF_SIZE, GFP_KERNEL);

the SOURCE is the virtual address of the pcie receive buffer obtained
by

gBaseVirt = ioremap(pci_resource_start (gDev, 0), gBaseLen);

the source address obtained by ioremap function (gBaseVirt) fails for
(virt_addr_valid((u32)) check.
In otherwords, ioremapped address is failing to generate its corresponding
physical address.

Can any one point out me what is going wrong here.

The failing point is pasted below:

void *xor_memcpy(void *to, const void *from, __kernel_size_t n)
{
        u32 xor_dma_unaligned_to, xor_dma_unaligned_from;
        void *orig_to = to;
        u32 to_pa, from_pa;
        int ua = 0;
        int         chan;
        struct xor_channel_t *channel;

        DPRINTK("xor_memcpy(0x%x, 0x%x, %lu): entering\n", (u32) to, (u32) from,
                (unsigned long)n);

        if (xor_engine_initialized == 0)
        {
            DPRINTK(KERN_WARNING" %s: xor engines not initialized
yet\n", __func__);
            xor_dma_miss++;
            return asm_memmove(to, from, n);
        }
        if (!(virt_addr_valid((u32) to) && virt_addr_valid((u32)
from))) { /*THE IOREMAPPED ADDRESS FAILS THIS CHECK*/
                DPRINTK("xor_memcpy(0x%x, 0x%x, %lu): falling back to memcpy\n",
                        (u32) to, (u32) from, (unsigned long)n);
                xor_dma_miss++;
                return asm_memmove(to, from, n);
        }

        /*
         * We can only handled completely cache-aligned transactions
         * with the DMA engine.  Source and Dst must be cache-line
         * aligned AND the length must be a multiple of the cache-line.
         */

        to_pa = virt_to_phys(to);
        from_pa = virt_to_phys((void*)from);

        if (((to_pa + n > from_pa) && (to_pa < from_pa)) ||
            ((from_pa < to_pa) && (from_pa + n > to_pa))) {
                DPRINTK("overlapping copy region (0x%x, 0x%x, %lu),
falling back\n",
                     to_pa, from_pa, (unsigned long)n);
                xor_dma_miss++;
                return asm_memmove(to, from, n);
        }
        /*
         * Ok, start addr is not cache line-aligned, so we need to make it so.
         */
        ........ .....
	........ .....

}


I am quite new in kernel. Please help me.

Thanks in advance
Regards,
Anish

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

