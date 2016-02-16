Return-Path: <vegard.nossum@oracle.com>
Subject: Re: [PATCH 1/3] usb: core: Allow compilation on platforms where
 NO_DMA=y
References: <1455535305-9508-1-git-send-email-geert@linux-m68k.org>
 <1455535305-9508-2-git-send-email-geert@linux-m68k.org>
 <56C1BB63.9070906@oracle.com>
 <CAMuHMdVxNS1_coU6EPZcHYKZqGnOPDmHq9_aQGa08jLNP55Nhg@mail.gmail.com>
 <56C2373A.4010701@oracle.com>
From: Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <56C3178C.80102@oracle.com>
Date: Tue, 16 Feb 2016 13:35:24 +0100
MIME-Version: 1.0
In-Reply-To: <56C2373A.4010701@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, John Youn <johnyoun@synopsys.com>, Richard Weinberger <richard@nod.at>, James McMechan <James_McMechan@hotmail.com>, Alan Stern <stern@rowland.harvard.edu>, Martin Schwidefsky <schwidefsky@de.ibm.com>, USB list <linux-usb@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 02/15/2016 09:38 PM, Vegard Nossum wrote:
> On 02/15/2016 01:28 PM, Geert Uytterhoeven wrote:
>> On Mon, Feb 15, 2016 at 12:49 PM, Vegard Nossum
>> <vegard.nossum@oracle.com> wrote:
>>> On 02/15/2016 12:21 PM, Geert Uytterhoeven wrote:

[...]

>>> Assuming this still lets the platform actually run USB drivers (which it
>>> looks like it does -- I still have to test it), then I'm all for it. You
>>
>> Please give it a try and let me know, as I'm not in a position to
>> test-run
>> this on Sun-3.
>
> Hrm, I can't quite get usb-over-ip working, I get this in the UML guest
> when trying to attach the host device:

[...]

> That said, I haven't tried if it works with my patches either, so it
> might be something else.

Ok, so I managed to get UML to read a USB flash drive plugged into the 
host machine using USB-over-IP:

mconsole (version 2) initialized on /home/vegard/.uml/eaqEV4/mconsole
Checking host MADV_REMOVE support...OK
UML Audio Relay (host dsp = /dev/sound/dsp, host mixer = /dev/sound/mixer)
[...]
vhci_hcd vhci_hcd: rhport(0) sockfd(3) devid(65538) speed(3) 
speed_str(high-speed)
usb 2-1: new high-speed USB device number 2 using vhci_hcd
usb 2-1: new high-speed USB device number 3 using vhci_hcd
usb 2-1: new high-speed USB device number 4 using vhci_hcd
usb 2-1: SetAddress Request (4) to port 0
usb 2-1: New USB device found, idVendor=0000, idProduct=0000
usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 2-1: Product: USB
usb 2-1: Manufacturer: SMI Corporation
usb 2-1: SerialNumber: AA627084901000000298
usb-storage 2-1:1.0: USB Mass Storage device detected
scsi host0: usb-storage 2-1:1.0
scsi 0:0:0:0: Direct-Access     ST       2GB              0000 PQ: 0 
ANSI: 0 CCS
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:0:0: [sda] 3915776 512-byte logical blocks: (2.00 GB/1.87 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 43 00 00 00
sd 0:0:0:0: [sda] No Caching mode page found
sd 0:0:0:0: [sda] Assuming drive cache: write through
  sda: sda1
sd 0:0:0:0: [sda] Attached SCSI removable disk

This is using your patches (on top of the ones Greg already took), so
feel free to add

     Acked-by: Vegard Nossum <vegard.nossum@oracle.com>

If you post the new version of your patch I can test that too :-)

Thanks,


Vegard

