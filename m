Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F3LmT-0000Eh-VX for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Jan 2006 15:16:25 -0800
Received: from bay101-f37.bay101.hotmail.com ([64.4.56.47] helo=hotmail.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1F3LmT-0001qc-2b
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Jan 2006 15:16:25 -0800
Message-ID: <BAY101-F378CFB5DBDD49226518EA3E2160@phx.gbl>
From: "James McMechan" <james_mcmechan@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_3107_6345_2d64"
Subject: [uml-devel] [PATCH] new version of ubd-many and uml_mconsole
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
Date: Sun, 29 Jan 2006 23:16:22 +0000
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_3107_6345_2d64
Content-Type: text/plain; format=flowed

Ok, I can't seem to make minor changes to ubd_kern to handle paged bitmaps 
so
I guess I will fall back my old cow_user.c with its library of 
cow_open/close/read/write
and working paged bitmaps

Here is the current version of cow-many against uml-2.6.15-bs1 it should be 
relatively unlimited as to # of ubd devices I was able to open my hard disk 
(read only since cow breaks) 986 times each with 3 partitions before running 
out of file descriptors and about 100 seperate major numbers all in the 
default mem=32M (29M were in use though). found a oddness formerly I called 
each major #'s container the ubd_controller# but that is too long for proc 
so now it is just ubd_bus# like the ide# for ide disk controllers.

if you use ubda in mconsole devices will be created with ubda as the disk 
name
if you use ubd0 in mconsole devices will be created with ubd0 as the disk 
name

I plan on using it to overlay my raid array hda-hds and have it use the real 
device #s
since the raid stuff seems to have them coded in as a check

For my use I will be setting MAX_MINOR 128 and UBD_SHIFT 6 for the 2 
devices/major like real ide drivers and MAX_LETTER 19 for drive ubds

on the command line
linux ubd=3 ubdaC27095H255S63=COWa,/dev/hda ubdbC20034H255S63=COWb,/dev/hdb 
...

and via uml_mconsole

config ubd=22 /* see the uml_mconsole patch to allow this to work */
config ubdcC20034H255S63=COWc,/dev/hdc
config ubddC20034H255S63=COWd,/dev/hdd
config ubd=33
config ubdeC20034H255S63=COWe,/dev/hde
...
config ubdsC20034H255S63=COWs,/dev/hds

I did not bother this time with keeping fake_ide/fake_major since this 
exactly maps to my
ide drives anyway, I also did not put in the config 
ubd=3,22,33,34,56,57,88,89,90,91
which would be the way to go for heavy use

I also noted the your V3 cow format does not comply with the 64bit alignment 
rules and
the compiler should insert a 32bit pad, or you could try __packed but that 
should
segfault a real 64bit machine I think AMD64/EMT64 may allow unaligned access
still someday PPC64/SPARC64/IA64 might get user mode linux and 64 bit 
machines used to be picky about things like that.

The current ubd_remove takes a integer rather than the device name this 
makes it harder to adjust for MAX_LETTER and knowing where the last ubd# is. 
it used to take the string from uml_mconsole which I just gave to parse_unit 
and the used the *dev to remove it now I have to go search for the number...

On a related note what is ubd_id() really supposed to do I am guessing it is 
the reporting function used to limit remove to the correct devices? I just 
found it in arch/um/drivers/mconsole_kern.c, so I end up calling parse_unit 
in ubd_id and then converting the device I found to a integer sending up for 
a range check which I just did and then back down to remove where I have to 
walk the list again to find that # to get the device I just had in ubd_id... 
seems a bit awkward I liked the string better.

Here are my thoughts about sequential formats for non-sparse filesystems 
(e.g. FAT32)

Indexed SAM fast but not very space efficient 1/64th of the disk size for 
the index alone
though we could make it 1/128 by limiting the sectors to 32bit but still 
ick.
u64 offset[blocks]
data...
so we get data[offset[sector]]

List SAM slower smaller? have to walk array 0..list_index to find if sector 
is present
list_index /* where we are in sector_number array */
list_limit /* how many sectors we are willing to remap can be less than all 
of the disk */
u64 sector_number[list_limit]
data...
for i=0;i<list_index;i++
    if sector_number[i] == sector then read data[i*sectorsize]

Direct SAM very slow but small--just record after record containing sector # 
and data
struct {
u64 sector_number
char data[sectorsize]
} record
i=0;
seek(fd,0)
do
read(fd,tmp,sizeof(tmp))
if tmp.sector_number == sector then we have the data in tmp.data break;
i++
while(!EOF)

Paged SAM since it only allocates 1 block of offsets at a time much smaller 
file
int mapsize /* 4k would seem a good starting point 512 S#/page allocated */
struct {
u64 sector_number[MAPSIZE/sizeof(u64)]
char data[MAPSIZE/sizeof(u64][sectorsize]
}
but you would have to walk the blocks


------=_NextPart_000_3107_6345_2d64
Content-Type: text/x-patch; name="ubd_kern.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="ubd_kern.patch"

--- uml-2.6.15-bs1/arch/um/drivers/ubd_kern.c	2006-01-28 12:20:06.000000000 -0800
+++ work-2.6.15-bs1/arch/um/drivers/ubd_kern.c	2006-01-29 15:12:35.000000000 -0800
@@ -14,11 +14,16 @@
  * the common /dev/ubd/discX/... names rather than
  * only /dev/ubdN/discN this version also has lots of
  * clean ups preparing for ubd-many.
+ * 2006-1-27 another try at ubd-many also drops fake ide, devfs
  * James McMechan
  */
 
-#define MAJOR_NR UBD_MAJOR
 #define UBD_SHIFT 4
+#define MAX_MINOR (256)
+/* ubd0..n maps to ubda-ubdh when n<8 */
+/* it can be increased though above 26 it will be strange */
+/* it can also apply to the extra buses based on UBD_SHIFT */
+#define MAX_LETTER (8)
 
 #include "linux/config.h"
 #include "linux/module.h"
@@ -118,8 +123,6 @@
 static int ubd_ioctl(struct inode * inode, struct file * file,
 		     unsigned int cmd, unsigned long arg);
 
-#define MAX_DEV (8)
-
 static struct block_device_operations ubd_blops = {
         .owner		= THIS_MODULE,
         .open		= ubd_open,
@@ -130,12 +133,6 @@
 /* Protected by the queue_lock */
 static request_queue_t *ubd_queue;
 
-/* Protected by ubd_lock */
-static int fake_major = MAJOR_NR;
-
-static struct gendisk *ubd_gendisk[MAX_DEV];
-static struct gendisk *fake_gendisk[MAX_DEV];
- 
 #ifdef CONFIG_BLK_DEV_UBD_SYNC
 #define OPEN_FLAGS ((struct openflags) { .r = 1, .w = 1, .s = 1, .c = 0, \
 					 .cl = 1 })
@@ -161,14 +158,20 @@
 
 struct ubd {
 	char *file;
+	struct ubd_bus *bus;
+	int unit;
 	int count;
 	int fd;
 	__u64 size;
 	struct openflags boot_openflags;
 	struct openflags openflags;
 	int no_cow;
+	int cylinders;
+	int heads;
+	int sectors;
 	struct cow cow;
 	struct platform_device pdev;
+	struct gendisk *gendisk;
 };
 
 #define DEFAULT_COW { \
@@ -181,6 +184,7 @@
 
 #define DEFAULT_UBD { \
 	.file = 		NULL, \
+	.bus = 			&first_bus, \
 	.count =		0, \
 	.fd =			-1, \
 	.size =			-1, \
@@ -188,13 +192,33 @@
 	.openflags =		OPEN_FLAGS, \
         .no_cow =               0, \
         .cow =			DEFAULT_COW, \
-}
-
-struct ubd ubd_dev[MAX_DEV] = { [ 0 ... MAX_DEV - 1 ] = DEFAULT_UBD };
+        .gendisk =		NULL, \
+        .cylinders =            0, \
+        .heads =                128, \
+        .sectors =              32, \
+}
+
+#define MAX_DEV (MAX_MINOR >> UBD_SHIFT)
+static int ubd_major = UBD_MAJOR;
+struct ubd_bus {
+	char name[32];
+	struct ubd_bus *next_bus;
+	int major;
+	int first_unit;
+	int last_unit;
+	struct ubd ubd_dev[MAX_DEV];
+} first_bus = {
+	.next_bus = NULL,
+	.major = UBD_MAJOR,
+	.first_unit = 0,
+	.last_unit = MAX_DEV,
+	.name = "ubd_bus0",
+	.ubd_dev = { [ 0 ... MAX_DEV - 1 ] = DEFAULT_UBD },
+};
 
 static int ubd0_init(void)
 {
-	struct ubd *dev = &ubd_dev[0];
+	struct ubd *dev = &first_bus.ubd_dev[0];
 
 	if(dev->file == NULL)
 		dev->file = "root_fs";
@@ -203,97 +227,121 @@
 
 __initcall(ubd0_init);
 
-/* Only changed by fake_ide_setup which is a setup */
-static int fake_ide = 0;
-static struct proc_dir_entry *proc_ide_root = NULL;
-static struct proc_dir_entry *proc_ide = NULL;
-
-static void make_proc_ide(void)
+enum {number,letter} name_type = letter;
+static struct ubd *parse_unit(char **ptr, int create)
 {
-	proc_ide_root = proc_mkdir("ide", NULL);
-	proc_ide = proc_mkdir("ide0", proc_ide_root);
-}
-
-static int proc_ide_read_media(char *page, char **start, off_t off, int count,
-			       int *eof, void *data)
-{
-	int len;
+	char *str = *ptr, *end;
+	int n = -1;
+	struct ubd_bus *bus;
+	struct ubd_bus *last_bus;
+	struct ubd *dev;
+	int count;
+	int i;
 
-	strcpy(page, "disk\n");
-	len = strlen("disk\n");
-	len -= off;
-	if (len < count){
-		*eof = 1;
-		if (len <= 0) return 0;
+	if(isdigit(*str)) {
+		n = simple_strtoul(str, &end, 0);
+		/* this should never occur we had a digit */
+		//if(end == str) n = -1;
+		*ptr = end;
+		name_type = number;
 	}
-	else len = count;
-	*start = page + off;
-	return len;
-}
+	else if (('a' <= *str) && (*str - 'a' < MAX_LETTER)) {
+		n = *str - 'a';
+		str++;
+		*ptr = str;
+		name_type = letter;
+	}
+	/* if we did not find the number */
+	if ((n < 0) && (!create)) return NULL;
 
-static void make_ide_entries(char *dev_name)
-{
-	struct proc_dir_entry *dir, *ent;
-	char name[64];
+	/* check to see if we have the bus for this device already */
+	count=0;
 
-	if(proc_ide_root == NULL) make_proc_ide();
+	/* we will hook to the last_bus if we fail */
+	last_bus = bus = &first_bus;
 
-	dir = proc_mkdir(dev_name, proc_ide);
-	if(!dir) return;
+	/* should always loop once on the first bus if unit not found */
+	while (bus && !((bus->first_unit <= n) && ( n < bus->last_unit))) {
+		count++;
+		last_bus = bus;
+		bus = bus->next_bus;
+	}
 
-	ent = create_proc_entry("media", S_IFREG|S_IRUGO, dir);
-	if(!ent) return;
-	ent->nlink = 1;
-	ent->data = NULL;
-	ent->read_proc = proc_ide_read_media;
-	ent->write_proc = NULL;
-	sprintf(name,"ide0/%s", dev_name);
-	proc_symlink(dev_name, proc_ide_root, name);
-}
+	/* we did not find a bus for our device create one */
+	if (!bus) {
+		int major;
+		/* we should be in the mconsole thread so GFP_KERNEL */
+		/* I have no clue what to do at boot time if we reach here */
+		bus = kmalloc(sizeof(struct ubd_bus), GFP_KERNEL);
+		if (!bus) {
+			printk(KERN_ERR "failed to allocate memory for a new device\n");
+			return NULL;
+		}
 
-static int fake_ide_setup(char *str)
-{
-	fake_ide = 1;
-	return(1);
-}
+		/* put in the name of the new bus */
+		sprintf(bus->name,"ubd_bus%d",count);
 
-__setup("fake_ide", fake_ide_setup);
+		/* major number 0 is used for dynamic numbering */
+		major = register_blkdev(ubd_major,bus->name);
+		/* check for dynamic case */
+		if ( ubd_major == 0 ) {
+			/* if we tried dynamic allocation 0 is a error */
+			if ( major == 0 ) {
+				printk(KERN_ERR "ubd: error getting dynamic major\n");
+				kfree(bus);
+				return NULL;
+			}
+		} else {
+			/* if we tried static allocation < 0 is a error */
+			if ( major < 0 ) {
+				printk(KERN_ERR "ubd: error getting major %d\n",ubd_major);
+				kfree(bus);
+				return NULL;
+			}
+			/* ok so we got our requested major */
+			major = ubd_major;
+		}
 
-__uml_help(fake_ide_setup,
-"fake_ide\n"
-"    Create ide0 entries that map onto ubd devices.\n\n"
-);
+		/* set to zero so next bus will get a dynamic number */
+		ubd_major = 0;
 
-static int parse_unit(char **ptr)
-{
-	char *str = *ptr, *end;
-	int n = -1;
+		/* this will be the last bus in the list */
+		bus->next_bus = NULL;
 
-	if(isdigit(*str)) {
-		n = simple_strtoul(str, &end, 0);
-		if(end == str)
-			return(-1);
-		*ptr = end;
-	}
-	else if (('a' <= *str) && (*str <= 'h')) {
-		n = *str - 'a';
-		str++;
-		*ptr = str;
+		/* we got back major as the major number */
+		bus->major = major;
+
+		/* and n with mask of 0x######00 to get the first # */
+		bus->first_unit = n & ~((1 << UBD_SHIFT) - 1);
+		bus->last_unit = bus->first_unit + MAX_DEV;
+
+		for (i = 0; i < MAX_DEV; i++) {
+			bus->ubd_dev[i] = ((struct ubd) DEFAULT_UBD);
+			bus->ubd_dev[i].bus = bus;
+			bus->ubd_dev[i].unit = bus->first_unit + i;
+		}
+		
+		/* and last add it to the list */
+		last_bus->next_bus = bus;
 	}
-	return(n);
+
+	if (bus->first_unit <= n && n < bus->last_unit) {
+		dev = &bus->ubd_dev[n - bus->first_unit];
+	} else dev = NULL;
+	return dev;
 }
 
-static int ubd_setup_common(char *str, int *index_out)
+static int ubd_setup_common(char *str,struct ubd **dev_out)
 {
-	struct ubd *dev;
+	struct ubd *dev = NULL;
 	struct openflags flags = global_openflags;
 	char *backing_file;
+	char *end;
 	int n, err, i;
 
-	if(index_out) *index_out = -1;
+	if (dev_out) *dev_out = NULL;
 	n = *str;
 	if(n == '='){
-		char *end;
 		int major;
 
 		str++;
@@ -307,49 +355,29 @@
 			       "ubd_setup : didn't parse major number\n");
 			return(1);
 		}
-
-		err = 1;
- 		spin_lock(&ubd_lock);
- 		if(fake_major != MAJOR_NR){
- 			printk(KERN_ERR "Can't assign a fake major twice\n");
- 			goto out1;
- 		}
- 
- 		fake_major = major;
-
-		printk(KERN_INFO "Setting extra ubd major number to %d\n",
-		       major);
- 		err = 0;
- 	out1:
- 		spin_unlock(&ubd_lock);
-		return(err);
+		/* we have a number even 0 (dynamic) is ok */
+		ubd_major = major;
+		printk(KERN_INFO "Setting new ubd major number to %d\n",
+				ubd_major);
+		return(0);
 	}
 
-	n = parse_unit(&str);
-	if(n < 0){
+	err = 1;
+	dev = parse_unit(&str,1);
+	if ( !dev ) {
 		printk(KERN_ERR "ubd_setup : couldn't parse unit number "
 		       "'%s'\n", str);
 		return(1);
 	}
-	if(n >= MAX_DEV){
-		printk(KERN_ERR "ubd_setup : index %d out of range "
-		       "(%d devices, from 0 to %d)\n", n, MAX_DEV, MAX_DEV - 1);
-		return(1);
-	}
 
-	err = 1;
 	spin_lock(&ubd_lock);
 
-	dev = &ubd_dev[n];
 	if(dev->file != NULL){
 		printk(KERN_ERR "ubd_setup : device already configured\n");
 		goto out;
 	}
 
-	if (index_out)
-		*index_out = n;
-
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < 7; i++) {
 		switch (*str) {
 		case 'r':
 			flags.w = 0;
@@ -360,6 +388,33 @@
 		case 'd':
 			dev->no_cow = 1;
 			break;
+		case 'C':
+			if ( !isdigit( str[1] ) ) {
+				printk(KERN_ERR "ubd_setup : problem with "
+					"cylinders %s\n",str);
+				goto out;
+			}
+			dev->cylinders = simple_strtoul(str+1, &end, 0);
+			str = end - 1; /* we will then increment to end */
+			break;
+		case 'H':
+			if ( !isdigit( str[1] ) ) {
+				printk(KERN_ERR "ubd_setup : problem with "
+					"heads %s\n",str);
+				goto out;
+			}
+			dev->heads = simple_strtoul(str+1, &end, 0);
+			str = end - 1; /* we will then increment to end */
+			break;
+		case 'S':
+			if ( !isdigit( str[1] ) ) {
+				printk(KERN_ERR "ubd_setup : problem with "
+					"sectors %s\n",str);
+				goto out;
+			}
+			dev->sectors = simple_strtoul(str+1, &end, 0);
+			str = end - 1; /* we will then increment to end */
+			break;
 		case '=':
 			str++;
 			goto break_loop;
@@ -396,9 +451,12 @@
 	dev->file = str;
 	dev->cow.file = backing_file;
 	dev->boot_openflags = flags;
+
+	/* ok we have a device do we have a place to put it */
+	if (dev_out) *dev_out = dev;
 out:
 	spin_unlock(&ubd_lock);
-	return(err);
+	return 0;
 }
 
 static int ubd_setup(char *str)
@@ -446,20 +504,6 @@
 "    in the boot output.\n\n"
 );
 
-static int fakehd_set = 0;
-static int fakehd(char *str)
-{
-	printk(KERN_INFO "fakehd : Changing ubd name to \"hd\".\n");
-	fakehd_set = 1;
-	return 1;
-}
-
-__setup("fakehd", fakehd);
-__uml_help(fakehd,
-"fakehd\n"
-"    Change the ubd device name to \"hd\".\n\n"
-);
-
 static void do_ubd_request(request_queue_t * q);
 
 /* Only changed by ubd_init, which is an initcall. */
@@ -620,59 +664,48 @@
 {
 }
 
-static int ubd_new_disk(int major, u64 size, int unit,
-			struct gendisk **disk_out)
+static int ubd_new_disk(struct ubd *dev)
 			
 {
 	struct gendisk *disk;
-	char from[sizeof("ubd/nnnnn\0")], to[sizeof("discnnnnn/disc\0")];
-	int err;
 
 	disk = alloc_disk(1 << UBD_SHIFT);
 	if(disk == NULL)
 		return(-ENOMEM);
 
-	disk->major = major;
-	disk->first_minor = unit << UBD_SHIFT;
+	disk->major = dev->bus->major;
+	disk->first_minor = (dev->unit - dev->bus->first_unit) << UBD_SHIFT;
 	disk->fops = &ubd_blops;
-	set_capacity(disk, size / 512);
-	if(major == MAJOR_NR){
-		sprintf(disk->disk_name, "ubd%c", 'a' + unit);
-		sprintf(disk->devfs_name, "ubd/disc%d", unit);
-		sprintf(from, "ubd/%d", unit);
-		sprintf(to, "disc%d/disc", unit);
-		err = devfs_mk_symlink(from, to);
-		if(err)
-			printk("ubd_new_disk failed to make link from %s to "
-			       "%s, error = %d\n", from, to, err);
-	}
-	else {
-		sprintf(disk->disk_name, "ubd_fake%d", unit);
-		sprintf(disk->devfs_name, "ubd_fake/disc%d", unit);
-	}
+	set_capacity(disk, dev->size / 512);
 
-	/* sysfs register (not for ide fake devices) */
-	if (major == MAJOR_NR) {
-		ubd_dev[unit].pdev.id   = unit;
-		ubd_dev[unit].pdev.name = DRIVER_NAME;
-		ubd_dev[unit].pdev.dev.release = dummy_device_release;
-		platform_device_register(&ubd_dev[unit].pdev);
-		disk->driverfs_dev = &ubd_dev[unit].pdev.dev;
-	}
+	/* should never have name_type of letter and unit > MAX */
+	/* but just in case. */
+	if ( name_type == letter && dev->unit < MAX_LETTER )
+		sprintf(disk->disk_name, "ubd%c", 'a' + dev->unit);
+	else
+		sprintf(disk->disk_name, "ubd%d", dev->unit);
+
+	/* do we still need devfs bits? it can't be enabled */
+	sprintf(disk->devfs_name, "ubd/disc%d", dev->unit);
+	/* sysfs register */
+	dev->pdev.id   = dev->unit;
+	dev->pdev.name = DRIVER_NAME;
+	dev->pdev.dev.release = dummy_device_release;
+	platform_device_register(&dev->pdev);
+	disk->driverfs_dev = &dev->pdev.dev;
 
-	disk->private_data = &ubd_dev[unit];
+	disk->private_data = dev;
 	disk->queue = ubd_queue;
 	add_disk(disk);
 
-	*disk_out = disk;
+	dev->gendisk = disk;
 	return 0;
 }
 
 #define ROUND_BLOCK(n) ((n + ((1 << 9) - 1)) & (-1 << 9))
 
-static int ubd_add(int n)
+static int ubd_add(struct ubd *dev)
 {
-	struct ubd *dev = &ubd_dev[n];
 	int err;
 
 	err = -ENODEV;
@@ -688,20 +721,8 @@
 
 	dev->size = ROUND_BLOCK(dev->size);
 
-	err = ubd_new_disk(MAJOR_NR, dev->size, n, &ubd_gendisk[n]);
-	if(err) 
-		goto out_close;
+	err = ubd_new_disk(dev);
  
-	if(fake_major != MAJOR_NR)
-		ubd_new_disk(fake_major, dev->size, n, 
-			     &fake_gendisk[n]);
-
-	/* perhaps this should also be under the "if (fake_major)" above */
-	/* using the fake_disk->disk_name and also the fakehd_set name */
-	if (fake_ide)
-		make_ide_entries(ubd_gendisk[n]->disk_name);
-
-	err = 0;
 out_close:
 	ubd_close(dev);
 out:
@@ -710,24 +731,25 @@
 
 static int ubd_config(char *str)
 {
-	int n, err;
+	int err;
+	struct ubd *dev;
 
 	str = uml_strdup(str);
 	if(str == NULL){
 		printk(KERN_ERR "ubd_config failed to strdup string\n");
 		return(1);
 	}
-	err = ubd_setup_common(str, &n);
+	err = ubd_setup_common(str, &dev);
 	if(err){
 		kfree(str);
 		return(-1);
 	}
-	if(n == -1) return(0);
+	if (!dev) return 0;
 
  	spin_lock(&ubd_lock);
-	err = ubd_add(n);
+	err = ubd_add(dev);
 	if(err)
-		ubd_dev[n].file = NULL;
+		dev->file = NULL;
  	spin_unlock(&ubd_lock);
 
 	return(err);
@@ -736,15 +758,14 @@
 static int ubd_get_config(char *name, char *str, int size, char **error_out)
 {
 	struct ubd *dev;
-	int n, len = 0;
+	int len = 0;
 
-	n = parse_unit(&name);
-	if((n >= MAX_DEV) || (n < 0)){
+	dev = parse_unit(&name,0);
+	if ( !dev ) {
 		*error_out = "ubd_get_config : device number out of range";
 		return(-1);
 	}
 
-	dev = &ubd_dev[n];
 	spin_lock(&ubd_lock);
 
 	if(dev->file == NULL){
@@ -768,24 +789,34 @@
 static int ubd_id(char **str, int *start_out, int *end_out)
 {
         int n;
+	struct ubd *dev;
 
-	n = parse_unit(str);
+	dev = parse_unit(str,0);
+	n = -1;
+	if (dev) n = dev->unit;
         *start_out = 0;
-        *end_out = MAX_DEV - 1;
+        *end_out = n;
         return n;
 }
 
 static int ubd_remove(int n)
 {
-	struct ubd *dev;
+	struct ubd *dev = NULL;
+	struct ubd_bus *bus = &first_bus;
 	int err = -ENODEV;
 
 	spin_lock(&ubd_lock);
 
-	if(ubd_gendisk[n] == NULL)
+	while (bus && !((bus->first_unit <= n) && ( n < bus->last_unit)))
+		bus = bus->next_bus;
+	if (bus)
+		dev = &bus->ubd_dev[n - bus->first_unit];
+
+	if(dev == NULL)
 		goto out;
 
-	dev = &ubd_dev[n];
+	if(dev->gendisk == NULL)
+		goto out;
 
 	if(dev->file == NULL)
 		goto out;
@@ -795,18 +826,14 @@
 	if(dev->count > 0)
 		goto out;
 
-	del_gendisk(ubd_gendisk[n]);
-	put_disk(ubd_gendisk[n]);
-	ubd_gendisk[n] = NULL;
-
-	if(fake_gendisk[n] != NULL){
-		del_gendisk(fake_gendisk[n]);
-		put_disk(fake_gendisk[n]);
-		fake_gendisk[n] = NULL;
-	}
+	del_gendisk(dev->gendisk);
+	put_disk(dev->gendisk);
+	dev->gendisk = NULL;
 
 	platform_device_unregister(&dev->pdev);
 	*dev = ((struct ubd) DEFAULT_UBD);
+	dev->bus = bus;
+	dev->unit = n;
 	err = 0;
 out:
 	spin_unlock(&ubd_lock);
@@ -838,28 +865,37 @@
 int ubd_init(void)
 {
         int i;
+	int result;
 
-	devfs_mk_dir("ubd");
-	if (register_blkdev(MAJOR_NR, "ubd"))
-		return -1;
+	result = register_blkdev(ubd_major, first_bus.name);
+	/* dynamic major # has 0 as the error result */
+	if (ubd_major == 0) {
+		/* if result is 0 we had a error */
+		if (result == 0)
+			return -1;
+		/* save the major number so queue fails deallocs correctly */
+		ubd_major = result;
+	/* fixed major number has < 0 as error result */
+	} else {
+		/* if result is < 0 we had a error */
+		if (result < 0)
+			return -1;
+	}
 
 	ubd_queue = blk_init_queue(do_ubd_request, &ubd_io_lock);
 	if (!ubd_queue) {
-		unregister_blkdev(MAJOR_NR, "ubd");
+		unregister_blkdev(ubd_major, first_bus.name);
 		return -1;
 	}
-		
-	if (fake_major != MAJOR_NR) {
-		char name[sizeof("ubd_nnn\0")];
 
-		snprintf(name, sizeof(name), "ubd_%d", fake_major);
-		devfs_mk_dir(name);
-		if (register_blkdev(fake_major, "ubd"))
-			return -1;
-	}
+	/* clear so future devices automaticlly assigned */
+	ubd_major = 0;
+		
 	platform_driver_register(&ubd_driver);
-	for (i = 0; i < MAX_DEV; i++) 
-		ubd_add(i);
+	for (i = 0; i < MAX_DEV; i++) {
+		first_bus.ubd_dev[i].unit = i;
+		ubd_add(&first_bus.ubd_dev[i]);
+	}
 	return 0;
 }
 
@@ -886,7 +922,7 @@
 		return(0);
 	}
 	err = um_request_irq(UBD_IRQ, thread_fd, IRQ_READ, ubd_intr, 
-			     SA_INTERRUPT, "ubd", ubd_dev);
+			     SA_INTERRUPT, "ubd", first_bus.ubd_dev);
 	if(err != 0)
 		printk(KERN_ERR "um_request_irq failed - errno = %d\n", -err);
 	return(err);
@@ -1074,20 +1110,25 @@
 		.heads		= 128,
 		.sectors	= 32,
 	};
+	/* replace default values with values parsed if present */
+	if (dev->heads) ubd_id.heads = dev->heads;
+	if (dev->sectors) ubd_id.sectors = dev->sectors;
+	if (dev->cylinders) ubd_id.cyls = dev->cylinders;
+	/* no parsed value compute a value */
+	else ubd_id.cyls = dev->size / ( ubd_id.heads * ubd_id.sectors * 512 );
 
 	switch (cmd) {
 	        struct hd_geometry g;
 		struct cdrom_volctrl volume;
 	case HDIO_GETGEO:
 		if(!loc) return(-EINVAL);
-		g.heads = 128;
-		g.sectors = 32;
-		g.cylinders = dev->size / (128 * 32 * 512);
+		g.heads = ubd_id.heads;
+		g.sectors = ubd_id.sectors;
+		g.cylinders = ubd_id.cyls;
 		g.start = get_start_sect(inode->i_bdev);
 		return(copy_to_user(loc, &g, sizeof(g)) ? -EFAULT : 0);
 
 	case HDIO_GET_IDENTITY:
-		ubd_id.cyls = dev->size / (128 * 32 * 512);
 		if(copy_to_user((char __user *) arg, (char *) &ubd_id,
 				 sizeof(ubd_id)))
 			return(-EFAULT);


------=_NextPart_000_3107_6345_2d64
Content-Type: text/x-patch; name="mconsole.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="mconsole.patch"

diff -Nur tools/mconsole/uml_mconsole.c tools-work/mconsole/uml_mconsole.c
--- tools/mconsole/uml_mconsole.c	2004-02-11 23:33:22.000000000 -0800
+++ tools-work/mconsole/uml_mconsole.c	2006-01-28 09:03:05.000000000 -0800
@@ -157,6 +157,9 @@
   if(*ptr == '\0') return(0);
 
   if(strncmp(ptr, "ubd", strlen("ubd"))) return(0);
+  
+  ptr += strlen("ubd");
+  if ( *ptr == '=' ) return 0;
 
   while((*ptr != '=') && (*ptr != '\0')) ptr++;
   if(*ptr == '\0') return(0);


------=_NextPart_000_3107_6345_2d64--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
