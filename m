Return-Path: <vegard.nossum@oracle.com>
Subject: Re: [PATCH 1/3] usb: core: Allow compilation on platforms where
 NO_DMA=y
References: <1455535305-9508-1-git-send-email-geert@linux-m68k.org>
 <1455535305-9508-2-git-send-email-geert@linux-m68k.org>
 <56C1BB63.9070906@oracle.com>
 <CAMuHMdVxNS1_coU6EPZcHYKZqGnOPDmHq9_aQGa08jLNP55Nhg@mail.gmail.com>
From: Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <56C2373A.4010701@oracle.com>
Date: Mon, 15 Feb 2016 21:38:18 +0100
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVxNS1_coU6EPZcHYKZqGnOPDmHq9_aQGa08jLNP55Nhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, John Youn <johnyoun@synopsys.com>, Richard Weinberger <richard@nod.at>, James McMechan <James_McMechan@hotmail.com>, Alan Stern <stern@rowland.harvard.edu>, Martin Schwidefsky <schwidefsky@de.ibm.com>, USB list <linux-usb@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 02/15/2016 01:28 PM, Geert Uytterhoeven wrote:
> On Mon, Feb 15, 2016 at 12:49 PM, Vegard Nossum
> <vegard.nossum@oracle.com> wrote:
>> On 02/15/2016 12:21 PM, Geert Uytterhoeven wrote:
>>> If NO_DMA=y:
>>>
>>>       ERROR: "dma_pool_destroy" [drivers/usb/core/usbcore.ko] undefined!
>>>       ERROR: "bad_dma_ops" [drivers/usb/core/usbcore.ko] undefined!
>>>       ERROR: "dma_pool_free" [drivers/usb/core/usbcore.ko] undefined!
>>>       ERROR: "dma_pool_alloc" [drivers/usb/core/usbcore.ko] undefined!
>>>       ERROR: "dma_pool_create" [drivers/usb/core/usbcore.ko] undefined!
>>>
>>> Add a few checks for CONFIG_HAS_DMA to fix this.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>> ---
>>>    drivers/usb/core/buffer.c | 18 ++++++++++++------
>>>    drivers/usb/core/hcd.c    | 14 ++++++++++----
>>>    2 files changed, 22 insertions(+), 10 deletions(-)
>>>
[...]

>> Assuming this still lets the platform actually run USB drivers (which it
>> looks like it does -- I still have to test it), then I'm all for it. You
>
> Please give it a try and let me know, as I'm not in a position to test-run
> this on Sun-3.

Hrm, I can't quite get usb-over-ip working, I get this in the UML guest
when trying to attach the host device:

# usbip -d attach -r 192.168.0.20 -b 2-1
usbip: debug: usbip.c:141:[run_command] running command: `attach'
libusbip: debug: vhci_driver.c:242:[usbip_vhci_driver_open] available 
ports: 7
libusbip: debug: vhci_driver.c:71:[parse_status] port 0 status 4 speed 0 
devid 0
libusbip: debug: vhci_driver.c:72:[parse_status] socket 0 lbusid 
0000000000000000
libusbip: debug: vhci_driver.c:71:[parse_status] port 1 status 4 speed 0 
devid 0
libusbip: debug: vhci_driver.c:72:[parse_status] socket 0 lbusid 
0000000000000000
libusbip: debug: vhci_driver.c:71:[parse_status] port 2 status 4 speed 0 
devid 0
libusbip: debug: vhci_driver.c:72:[parse_status] socket 0 lbusid 
0000000000000000
libusbip: debug: vhci_driver.c:71:[parse_status] port 3 status 4 speed 0 
devid 0
libusbip: debug: vhci_driver.c:72:[parse_status] socket 0 lbusid 
0000000000000000
libusbip: debug: vhci_driver.c:71:[parse_status] port 4 status 4 speed 0 
devid 0
libusbip: debug: vhci_driver.c:72:[parse_status] socket 0 lbusid 
0000000000000000
libusbip: debug: vhci_driver.c:71:[parse_status] port 5 status 4 speed 0 
devid 0
libusbip: debug: vhci_driver.c:72:[parse_status] socket 0 lbusid 
0000000000000000
libusbip: debug: vhci_driver.c:71:[parse_status] port 6 status 4 speed 0 
devid 0
libusbip: debug: vhci_driver.c:72:[parse_status] socket 0 lbusid 
0000000000000000
libusbip: debug: vhci_driver.c:71:[parse_status] port 7 status 4 speed 0 
devid 0
libusbip: debug: vhci_driver.c:72:[parse_status] socket 0 lbusid 
0000000000000000
libusbip: debug: vhci_driver.c:105:[parse_status] exit
libusbip: debug: vhci_driver.c:311:[usbip_vhci_attach_device2] writing: 
0 3 131074 5
libusbip: debug: vhci_driver.c:316:[usbip_vhci_attach_device2] attach 
attribute path: /sys/devices/platform/vhci_hcd/attach
vhci_hcd: Failed attach request for unsupported USB speed: super-speed
usbip: debug: sysfs_utils.c:23:[write_sysfs_attribute] error writing to 
attribute /sys/devices/platform/vhci_hcd/attach
libusbip: debug: vhci_driver.c:320:[usbip_vhci_attach_device2] 
write_sysfs_attribute failed
usbip: error: import device
usbip: error: query

That said, I haven't tried if it works with my patches either, so it
might be something else.

I'll dive into it tomorrow.


Vegard

