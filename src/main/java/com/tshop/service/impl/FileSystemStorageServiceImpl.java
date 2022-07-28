package com.tshop.service.impl;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;


import com.tshop.config.StorageProperies;
import com.tshop.exception.StorageException;
import com.tshop.exception.StorageFileNotFoundException;
import com.tshop.service.StorageService;

import org.apache.commons.io.FilenameUtils;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileSystemStorageServiceImpl implements StorageService {
	private final Path rootLocation;
	
	@Override
	public String getStoredFileName(MultipartFile file, String id) {
		String ext = FilenameUtils.getExtension(file.getOriginalFilename());
		
		return "p" + id + "." + ext;
	}
	
	public FileSystemStorageServiceImpl(StorageProperies properies) {
		this.rootLocation = Paths.get(properies.getLocation());
	}
	
	@Override
	public void store(MultipartFile file, String storedFilename) {
		try {
			if(file.isEmpty()) {
				throw new StorageException("Failed to store empty file.");
			}
			
			Path destinationFile = this.rootLocation.resolve(Paths.get(storedFilename))
					.normalize().toAbsolutePath();
			
			if(!destinationFile.getParent().equals(this.rootLocation.toAbsolutePath())) {
				throw new StorageException("Cannot store file outside current directory.");
			}
			
			try (InputStream inputStream = file.getInputStream()) {
				Files.copy(inputStream, destinationFile, StandardCopyOption.REPLACE_EXISTING);
			}
			
		} catch (Exception e) {
			throw new StorageException("Failed to store file :", e);
		}
	}
	
	@Override
	public Resource loadAsResource(String filename) {
		try {
			Path file = load(filename);
			Resource resource = new UrlResource(file.toUri());
			if(resource.exists() || resource.isReadable()) {
				return resource;
			}
			
			throw new StorageFileNotFoundException("Could not read file: " + filename);
		} catch (Exception e) {
			throw new StorageFileNotFoundException("Could not read file: " + filename);
		}
	}
	
	@Override
	public Path load(String filename) {
		
		return this.rootLocation.resolve(filename);
	}
	
	@Override
	public void delete(String storedFilename) throws IOException {
		Path destinationFile = this.rootLocation.resolve(Paths.get(storedFilename))
				.normalize().toAbsolutePath();
		
		Files.delete(destinationFile);
	}
	
	@Override
	public void init() {
		try {
			Files.createDirectories(this.rootLocation);
			
			System.out.println(this.rootLocation.toString());
		} catch (Exception e) {
			throw new StorageException("Could not initialize storage.", e);
		}
	}
}
