Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iIC6w-0005GO-OU
 for linux-um@lists.infradead.org; Wed, 09 Oct 2019 13:34:40 +0000
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6]
 helo=jain.kot-begemot.co.uk)
 by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <anton.ivanov@cambridgegreys.com>)
 id 1iIC6n-0008D0-R5
 for linux-um@lists.infradead.org; Wed, 09 Oct 2019 13:34:30 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
 by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
 (envelope-from <anton.ivanov@cambridgegreys.com>) id 1iIC6l-0000aj-FC
 for linux-um@lists.infradead.org; Wed, 09 Oct 2019 14:34:29 +0100
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: RFC - make it possible to add iomem at runtime.
Message-ID: <841ebee1-8ef3-b4d8-ba60-925461ad6ee9@cambridgegreys.com>
Date: Wed, 9 Oct 2019 14:34:27 +0100
MIME-Version: 1.0
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org

Hi all,

I am looking at adding an af_xdp network transport. As a part of its 
initialization it needs to allocate a memory area to be shared for tx/rx 
buffers. I would like to do that without dipping into the "normal" UML 
memory pool if possible.

The only way to allocate this at present is to pass it as an iomem 
"region". This, however, is a bit dated and limited - it assumes an 
existing file on a block device which is added at boot and not changed 
after that. I cannot for example allocate at runtime and map that as iomem.

I was wondering if we can relax the "on-boot" only requirement and allow 
allocations to happen during runtime as the drivers get initialized. 
This will make implementing af_xdp and/or tpacket as well as various 
memifs as network transports much easier.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

